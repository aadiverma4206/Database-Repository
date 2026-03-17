import { ComponentFixture, TestBed } from '@angular/core/testing';
import { TableDataPage } from './table-data.page';

describe('TableDataPage', () => {
  let component: TableDataPage;
  let fixture: ComponentFixture<TableDataPage>;

  beforeEach(() => {
    fixture = TestBed.createComponent(TableDataPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
