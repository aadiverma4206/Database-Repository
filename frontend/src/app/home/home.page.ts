import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { Router } from '@angular/router';
import { addIcons } from 'ionicons';
import { 
  folderOpenOutline, 
  settingsOutline, 
  chevronForwardOutline 
} from 'ionicons/icons';
import {
  IonHeader,
  IonToolbar,
  IonTitle,
  IonContent,
  IonIcon,
  IonCard,
  IonCardContent
} from '@ionic/angular/standalone';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
  standalone: true,
  imports: [
    CommonModule,
    HttpClientModule,
    IonHeader,
    IonToolbar,
    IonTitle,
    IonContent,
    IonIcon,
    IonCard,
    IonCardContent
  ],
})
export class HomePage implements OnInit {

  databaseList: any[] = [];

  userDatabases: any[] = [];
  
  systemDatabases: any[] = [];

  systemDbNames: string[] = [
    'information_schema',
    'mysql',
    'performance_schema',
    'sys'
  ];

  constructor(
    private http: HttpClient,
    private router: Router
  ) {}

  ngOnInit() {
    this.getDatabases();

    addIcons({
      folderOpenOutline,
      settingsOutline,
      chevronForwardOutline
    });
  }

  getDatabases() {
    this.http
      .get<any[]>('http://localhost:3000/databases')
      .subscribe({
        next: (res) => {

          this.databaseList = res || [];

          // SPLIT LOGIC
          this.userDatabases = this.databaseList.filter(
            db => !this.systemDbNames.includes(db.Database)
          );

          this.systemDatabases = this.databaseList.filter(
            db => this.systemDbNames.includes(db.Database)
          );

        },
        error: (err) => {
          console.error('Error fetching databases:', err);
          this.databaseList = [];
          this.userDatabases = [];
          this.systemDatabases = [];
        }
      });
  }

  openDatabase(dbName: string) {
    if (!dbName) return;
    this.router.navigate(['/table-show', dbName]);
  }

  // ADDED: trackBy function (fixes error + improves performance)
  trackByDb(index: number, item: any): string {
    return item?.Database || index.toString();
  }
}