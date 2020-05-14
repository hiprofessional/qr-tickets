import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ViewRoutingModule } from './view-routing.module';
import { UsersListComponent } from './users/users-list/users-list.component';
import { UsersDetailsComponent } from './users/users-details/users-details.component';
import { TicketDetailsComponent } from './ticket/ticket-details/ticket-details.component';
import { SignUpComponent } from './sign-up/sign-up.component';
import { SignInComponent } from './sign-in/sign-in.component';
import { ReactiveFormsModule } from '@angular/forms';
import { SharedModule } from '../shared/shared.module';


@NgModule({
  declarations: [UsersListComponent, UsersDetailsComponent, TicketDetailsComponent, SignUpComponent, SignInComponent],
  imports: [
    CommonModule,
    ViewRoutingModule,
    ReactiveFormsModule,
    SharedModule
  ]
})
export class ViewModule { }
