import { ComponentFixture, TestBed } from '@angular/core/testing';
import { TableInfoPage } from './table-info.page';

describe('TableInfoPage', () => {
  let component: TableInfoPage;
  let fixture: ComponentFixture<TableInfoPage>;

  beforeEach(() => {
    fixture = TestBed.createComponent(TableInfoPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
