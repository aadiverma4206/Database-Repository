import { ComponentFixture, TestBed } from '@angular/core/testing';
import { TableShowPage } from './table-show.page';

describe('TableShowPage', () => {
  let component: TableShowPage;
  let fixture: ComponentFixture<TableShowPage>;

  beforeEach(() => {
    fixture = TestBed.createComponent(TableShowPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
