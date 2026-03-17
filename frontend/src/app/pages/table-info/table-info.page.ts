import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router } from '@angular/router';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { AlertController } from '@ionic/angular';
import * as XLSX from 'xlsx';
import { saveAs } from 'file-saver';

import { addIcons } from 'ionicons';
import { documentAttachOutline, createOutline } from 'ionicons/icons';

import {
  IonHeader,
  IonToolbar,
  IonTitle,
  IonContent,
  IonButtons,
  IonBackButton,
  IonButton,
  IonIcon
} from '@ionic/angular/standalone';

@Component({
  selector: 'app-table-info',
  templateUrl: './table-info.page.html',
  styleUrls: ['./table-info.page.scss'],
  standalone: true,
  imports: [
    CommonModule,
    HttpClientModule,
    IonHeader,
    IonToolbar,
    IonTitle,
    IonContent,
    IonButtons,
    IonBackButton,
    IonButton,
    IonIcon
  ],
})
export class TableInfoPage implements OnInit {

  dbName: string = '';
  tableName: string = '';
  columnList: any[] = [];

  tableComment: string = '';
  tableDescription: string = '';

  // IMPORTANT (NOT REMOVED)
  displayedColumns: string[] = [
    'ORDINAL_POSITION',
    'COLUMN_NAME',
    'COLUMN_TYPE',
    'COLLATION_NAME',
    'COLUMN_KEY',
    'EXTRA',
    'COLUMN_COMMENT'
  ];

  constructor(
    private route: ActivatedRoute,
    private http: HttpClient,
    private alertController: AlertController,
    private router: Router
  ) {
    //  Register icons for standalone
    addIcons({
      documentAttachOutline,
      createOutline
    });
  }

  ngOnInit() {
    this.dbName = this.route.snapshot.paramMap.get('dbname') || '';
    this.tableName = this.route.snapshot.paramMap.get('tablename') || '';
    this.getTableInfo();
  }

  getTableInfo() {

    if (!this.dbName || !this.tableName) {
      console.warn('Missing database or table name');
      return;
    }

    this.http
      .get<any>(
        `http://localhost:3000/table-info/${this.dbName}/${this.tableName}`
      )
      .subscribe({
        next: (res) => {
          this.columnList = res?.columns || [];
          this.tableComment = res?.tableComment || 'No comment available';
        },
        error: (err) => {
          console.error('Error fetching table info:', err);
          this.columnList = [];
          this.tableComment = '';
          this.tableDescription = '';
        }
      });
  }

  async openEditComment() {

    const alert = await this.alertController.create({
      header: 'Edit Table Comment',
      cssClass: 'modern-light-alert',
      inputs: [
        {
          name: 'comment',
          type: 'textarea',
          value: this.tableComment,
          placeholder: 'Write your comment here...',
          attributes: { rows: 4 }
        }
      ],
      buttons: [
        {
          text: 'Cancel',
          role: 'cancel',
          cssClass: 'modern-light-alert',
        },
        {
          text: 'Save',
          cssClass: 'modern-light-alert',
          handler: (data) => {
            if (data.comment !== undefined) {
              this.updateComment(data.comment);
            }
          }
        }
      ]
    });

    await alert.present();
  }

  updateComment(newComment: string) {

    this.http.put(
      `http://localhost:3000/update-table-comment/${this.dbName}/${this.tableName}`,
      { comment: newComment }
    ).subscribe({
      next: () => {
        this.tableComment = newComment;
        console.log("Table comment updated successfully");
      },
      error: (err) => {
        console.error("Update failed:", err);
      }
    });
  }

  async openEditColumnComment(row: any) {

    const alert = await this.alertController.create({
      header: `Edit Comment (${row.COLUMN_NAME})`,
      cssClass: 'modern-light-alert',
      inputs: [
        {
          name: 'comment',
          type: 'textarea',
          value: row.COLUMN_COMMENT,
          placeholder: 'Write column comment...',
          attributes: { rows: 4 }
        }
      ],
      buttons: [
        {
          text: 'Cancel',
          role: 'cancel'
        },
        {
          text: 'Save',
          handler: (data) => {
            if (data.comment !== undefined) {
              this.updateColumnComment(row, data.comment);
            }
          }
        }
      ]
    });

    await alert.present();
  }

  updateColumnComment(row: any, newComment: string) {

    this.http.put(
      `http://localhost:3000/update-column-comment/${this.dbName}/${this.tableName}/${row.COLUMN_NAME}`,
      { comment: newComment }
    ).subscribe({
      next: () => {

        //  Update UI instantly (No reload)
        row.COLUMN_COMMENT = newComment;

        console.log("Column comment updated successfully");

      },
      error: (err) => {
        console.error("Column update failed:", err);
      }
    });
  }

  viewTableData() {
    this.router.navigate([
      '/table-data',
      this.dbName,
      this.tableName
    ]);
  }

  async exportToExcel() {

    if (!this.columnList || this.columnList.length === 0) {

      const alert = await this.alertController.create({
        header: 'No Data',
        message: 'No data available to export.',
        buttons: ['OK']
      });

      await alert.present();
      return;
    }

    const formattedData = this.columnList.map((row: any) => ({
      "Sr. No.": row.ORDINAL_POSITION,
      "Column Name": row.COLUMN_NAME,
      "Datatype": row.COLUMN_TYPE,
      "Collation Name": row.COLLATION_NAME || '—',
      "Key": row.COLUMN_KEY || '—',
      "Extra": row.EXTRA || '—',
      "Description": row.COLUMN_COMMENT || '—'
    }));

    const worksheet: XLSX.WorkSheet =
      XLSX.utils.json_to_sheet(formattedData);

    worksheet['!cols'] = [
      { wch: 8 },
      { wch: 20 },
      { wch: 18 },
      { wch: 18 },
      { wch: 10 },
      { wch: 15 },
      { wch: 30 }
    ];

    const workbook: XLSX.WorkBook = {
      Sheets: { 'Structure': worksheet },
      SheetNames: ['Structure']
    };

    const excelBuffer = XLSX.write(workbook, {
      bookType: 'xlsx',
      type: 'array'
    });

    const blob = new Blob([excelBuffer], {
      type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    });

    saveAs(blob, `${this.tableName}_Structure.xlsx`);//excel sheet name tablename_Structure.
  }
}