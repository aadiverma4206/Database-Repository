import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { HttpClient, HttpClientModule } from '@angular/common/http';

import {
  IonContent,
  IonHeader,
  IonTitle,
  IonToolbar,
  IonButtons,
  IonBackButton
} from '@ionic/angular/standalone';

@Component({
  selector: 'app-table-data',
  templateUrl: './table-data.page.html',
  styleUrls: ['./table-data.page.scss'],
  standalone: true,
  imports: [
    IonContent,
    IonHeader,
    IonTitle,
    IonToolbar,
    IonButtons,
    IonBackButton,
    CommonModule,
    FormsModule,
    HttpClientModule
  ]
})
export class TableDataPage implements OnInit {

  dbName: string = '';
  tableName: string = '';

  columns: string[] = [];
  rows: any[] = [];

  constructor(
    private route: ActivatedRoute,
    private http: HttpClient
  ) {}

  ngOnInit() {
    this.dbName = this.route.snapshot.paramMap.get('dbname') || '';
    this.tableName = this.route.snapshot.paramMap.get('tablename') || '';

    this.loadTableData();
  }

  loadTableData() {

    if (!this.dbName || !this.tableName) {
      console.error('Database or table name missing');
      return;
    }

    this.http
      .get<any>(
        `http://localhost:3000/table-data/${this.dbName}/${this.tableName}`
      )
      .subscribe({
        next: (res) => {
          this.columns = res?.columns || [];
          this.rows = res?.rows || [];
        },
        error: (err) => {
          console.error('Error fetching table data:', err);
          this.columns = [];
          this.rows = [];
        }
      });

  }

}