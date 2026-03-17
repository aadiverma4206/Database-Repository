import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router } from '@angular/router';
import { HttpClient, HttpClientModule } from '@angular/common/http';

import {
  IonHeader,
  IonToolbar,
  IonTitle,
  IonContent,
  IonButtons,
  IonBackButton,
  IonIcon   //  REQUIRED
} from '@ionic/angular/standalone';

@Component({
  selector: 'app-table-show',
  templateUrl: './table-show.page.html',
  styleUrls: ['./table-show.page.scss'],
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
    IonIcon   //  REQUIRED
  ],
})
export class TableShowPage implements OnInit {

  dbName: string = '';
  tableList: any[] = [];

  constructor(
    private route: ActivatedRoute,
    private http: HttpClient,
    private router: Router
  ) {}

  ngOnInit() {
    this.dbName = this.route.snapshot.paramMap.get('dbname') || '';
    this.getTables();
  }

  // Runs when navigating back from table-info
  ionViewWillEnter() {
    this.getTables();
  }

  getTables() {
    if (!this.dbName) {
      console.error('Database name not found in route');
      return;
    }

    this.http
      .get<any[]>(`http://localhost:3000/tables/${this.dbName}`)
      .subscribe({
        next: (res) => {
          this.tableList = res || [];
        },
        error: (err) => {
          console.error("Error fetching tables:", err);
          this.tableList = [];
        }
      });
  }

  openTable(tableName: string) {
    if (!tableName) return;
    this.router.navigate(['/table-info', this.dbName, tableName]);
  }
}