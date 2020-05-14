import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { UserService } from 'src/app/core/services/user.service';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-users-details',
  templateUrl: './users-details.component.html',
  styleUrls: ['./users-details.component.scss']
})
export class UsersDetailsComponent implements OnInit {
  userForm: FormGroup;
  userId: number;
  constructor(private fb: FormBuilder,
    private userService: UserService,
    private route: ActivatedRoute,
  ) { }

  ngOnInit(): void {
    this.initForm();
    this.getData();
  }

  initForm() {
    this.userForm = this.fb.group({
      Id: [],
      Name: [],
      Email: [],
      Ticket: this.fb.group({
        Id: [],
        Image: []
      })
    })
  }

  get ticket() {
    return this.userForm.get('Ticket');
  }

  getData() {
    this.userId = +this.route.snapshot.paramMap.get('id');
    this.userForm.disable();
    this.userService.getUserById(this.userId).subscribe(data => {
      this.userForm.patchValue(data);
      this.userForm.enable();
    }, err => {
      this.userForm.enable();
      console.log(err);
    }
    );
  }

}
