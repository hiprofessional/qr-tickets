import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ValidationErrorsComponent } from './validation-errors/validation-errors.component';
import { TopNavigationComponent } from './top-navigation/top-navigation.component';
import { RouterModule } from '@angular/router';

@NgModule({
  declarations: [ValidationErrorsComponent, TopNavigationComponent],
  imports: [
    CommonModule,
    RouterModule
  ],
  exports: [
    ValidationErrorsComponent,
    TopNavigationComponent,
  ]
})
export class SharedModule { }
