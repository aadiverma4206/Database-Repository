import { Routes } from '@angular/router';

export const routes: Routes = [

  {
    path: 'home',
    loadComponent: () =>
      import('./home/home.page')
        .then(m => m.HomePage),
  },

  {
    path: '',
    redirectTo: 'home',
    pathMatch: 'full',
  },

  //  Database → Tables
  {
    path: 'table-show/:dbname',
    loadComponent: () =>
      import('./pages/table-show/table-show.page')
        .then(m => m.TableShowPage),
  },

  //  Tables → Table Info
  {
    path: 'table-info/:dbname/:tablename',
    loadComponent: () =>
      import('./pages/table-info/table-info.page')
        .then(m => m.TableInfoPage),
  },

  //  NEW: Table Info → Table Data
  {
    path: 'table-data/:dbname/:tablename',
    loadComponent: () =>
      import('./pages/table-data/table-data.page')
        .then(m => m.TableDataPage),
  },

];