import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { UserService } from 'src/app/core/services/user.service';

@Component({
  selector: 'app-users-list',
  templateUrl: './users-list.component.html',
  styleUrls: ['./users-list.component.scss']
})
export class UsersListComponent implements OnInit {
  users: User[] = [];
  constructor(
    private userService: UserService
  ) { }

  ngOnInit(): void {
    this.getData();
  }

  getData() {
    this.userService.getUsers().subscribe(data => {
      this.users = data;
    })
  }

}
