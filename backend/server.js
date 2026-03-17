const express = require('express');
const cors = require('cors');
const mysql = require('mysql2');

const app = express();

app.use(cors());
app.use(express.json());

// conntection pool
const db = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: 'system',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

console.log("MariaDB Pool Created");
//get all databases
app.get('/databases', (req, res) => {

  db.query("SHOW DATABASES", (err, result) => {
    if (err) {
      console.error("Error fetching databases:", err);
      return res.status(500).json({ success: false, message: err.message });
    }

    res.json(result);
  });

});
//get table and comment
app.get('/tables/:dbname', (req, res) => {

  const dbName = req.params.dbname;

  if (!dbName || !/^[a-zA-Z0-9_]+$/.test(dbName)) {
    return res.status(400).json({
      success: false,
      message: "Invalid database name"
    });
  }

  const query = `
    SELECT 
      TABLE_NAME,
      TABLE_COMMENT
    FROM information_schema.TABLES
    WHERE TABLE_SCHEMA = ?
  `;

  db.query(query, [dbName], (err, result) => {
    if (err) {
      console.error("Error fetching tables:", err);
      return res.status(500).json({ success: false, message: err.message });
    }

    res.json(result);
  });

});
//get table structure and table comment..
app.get('/table-info/:dbname/:tablename', (req, res) => {

  const { dbname, tablename } = req.params;

  if (
    !dbname || !tablename ||
    !/^[a-zA-Z0-9_]+$/.test(dbname) ||
    !/^[a-zA-Z0-9_]+$/.test(tablename)
  ) {
    return res.status(400).json({
      success: false,
      message: "Invalid database or table name"
    });
  }

  const tableQuery = `
    SELECT TABLE_COMMENT
    FROM information_schema.TABLES
    WHERE TABLE_SCHEMA = ?
    AND TABLE_NAME = ?
  `;

  const columnQuery = `
    SELECT 
      ORDINAL_POSITION,
      COLUMN_NAME,
      COLUMN_TYPE,
      COLLATION_NAME,
      COLUMN_KEY,
      EXTRA,
      COLUMN_COMMENT
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = ?
    AND TABLE_NAME = ?
    ORDER BY ORDINAL_POSITION
  `;

  db.query(tableQuery, [dbname, tablename], (err, tableResult) => {

    if (err) {
      console.error("Error fetching table metadata:", err);
      return res.status(500).json({ success: false, message: err.message });
    }

    db.query(columnQuery, [dbname, tablename], (err, columnResult) => {

      if (err) {
        console.error("Error fetching column info:", err);
        return res.status(500).json({ success: false, message: err.message });
      }

      res.json({
        tableComment: tableResult?.[0]?.TABLE_COMMENT || '',
        columns: columnResult || []
      });

    });

  });

});
//update table comment
app.put('/update-table-comment/:dbname/:tablename', (req, res) => {

  const { dbname, tablename } = req.params;
  const { comment } = req.body;

  if (
    !dbname || !tablename ||
    !/^[a-zA-Z0-9_]+$/.test(dbname) ||
    !/^[a-zA-Z0-9_]+$/.test(tablename)
  ) {
    return res.status(400).json({
      success: false,
      message: "Invalid database or table name"
    });
  }

  if (typeof comment !== 'string') {
    return res.status(400).json({
      success: false,
      message: "Invalid comment"
    });
  }

  const query = `
    ALTER TABLE \`${dbname}\`.\`${tablename}\`
    COMMENT = ?
  `;

  db.query(query, [comment], (err) => {

    if (err) {
      console.error("Error updating table comment:", err);
      return res.status(500).json({ success: false, message: err.message });
    }

    res.json({
      success: true,
      message: "Table comment updated successfully"
    });

  });

});
//update column comment
app.put('/update-column-comment/:dbname/:tablename/:columnname', (req, res) => {

  const { dbname, tablename, columnname } = req.params;
  const { comment } = req.body;

  if (
    !dbname || !tablename || !columnname ||
    !/^[a-zA-Z0-9_]+$/.test(dbname) ||
    !/^[a-zA-Z0-9_]+$/.test(tablename) ||
    !/^[a-zA-Z0-9_]+$/.test(columnname)
  ) {
    return res.status(400).json({
      success: false,
      message: "Invalid database, table or column name"
    });
  }

  if (typeof comment !== 'string') {
    return res.status(400).json({
      success: false,
      message: "Invalid comment"
    });
  }

  // Get full column definition
  const getColumnQuery = `
    SELECT COLUMN_TYPE, IS_NULLABLE, COLUMN_DEFAULT, EXTRA
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = ?
    AND TABLE_NAME = ?
    AND COLUMN_NAME = ?
  `;

  db.query(getColumnQuery, [dbname, tablename, columnname], (err, result) => {

    if (err || result.length === 0) {
      console.error("Error fetching column definition:", err);
      return res.status(500).json({ success: false, message: "Column not found" });
    }

    const column = result[0];

    let alterQuery = `
      ALTER TABLE \`${dbname}\`.\`${tablename}\`
      MODIFY COLUMN \`${columnname}\` ${column.COLUMN_TYPE}
    `;

    // NULL / NOT NULL handling
    if (column.IS_NULLABLE === 'NO') {
      alterQuery += ' NOT NULL';
    } else {
      alterQuery += ' NULL';
    }

    // DEFAULT handling (FIXED PROPERLY)
    if (column.COLUMN_DEFAULT !== null) {

      if (column.COLUMN_DEFAULT.toUpperCase() === 'CURRENT_TIMESTAMP') {
        alterQuery += ' DEFAULT CURRENT_TIMESTAMP';
      } else {
        alterQuery += ` DEFAULT ${db.escape(column.COLUMN_DEFAULT)}`;
      }

    } else if (column.IS_NULLABLE === 'YES') {
      alterQuery += ' DEFAULT NULL';
    }

    // EXTRA (auto_increment etc.)
    if (column.EXTRA) {
      alterQuery += ` ${column.EXTRA}`;
    }

    // COMMENT (parameterized)
    alterQuery += ` COMMENT ?`;

    db.query(alterQuery, [comment], (err2) => {

      if (err2) {
        console.error("Error updating column comment:", err2);
        return res.status(500).json({ success: false, message: err2.message });
      }

      res.json({
        success: true,
        message: "Column comment updated successfully"
      });

    });

  });

});
//get table data
app.get('/table-data/:dbname/:tablename', (req, res) => {

  const { dbname, tablename } = req.params;

  if (
    !dbname || !tablename ||
    !/^[a-zA-Z0-9_]+$/.test(dbname) ||
    !/^[a-zA-Z0-9_]+$/.test(tablename)
  ) {
    return res.status(400).json({
      success: false,
      message: "Invalid database or table name"
    });
  }

  const limit = parseInt(req.query.limit) || 500;

  const query = `
    SELECT * FROM \`${dbname}\`.\`${tablename}\`
    LIMIT ?
  `;

  db.query(query, [limit], (err, rows) => {

    if (err) {
      console.error("Error fetching table data:", err);
      return res.status(500).json({ success: false, message: err.message });
    }

    const columns = rows.length > 0
      ? Object.keys(rows[0])
      : [];

    res.json({
      columns,
      rows
    });

  });

});
//server start
app.listen(3000, () => {
  console.log("Server running on http://localhost:3000");
  console.log("DataBase Connected!!!...");
});