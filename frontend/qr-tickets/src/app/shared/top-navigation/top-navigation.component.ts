import { Component, OnInit } from '@angular/core';
import { AuthenticationService } from 'src/app/core/services/authentication.service';
import { Router } from '@angular/router';
import { CurrentPerson } from 'src/app/models/user';

@Component({
  selector: 'app-top-navigation',
  templateUrl: './top-navigation.component.html',
  styleUrls: ['./top-navigation.component.scss']
})
export class TopNavigationComponent implements OnInit {
  currentPerson: CurrentPerson;
  constructor(private authService: AuthenticationService,
    public router: Router
    ) { }

  ngOnInit(): void {
    this.authService.getCurrentPerson().subscribe(data => {
      if (data) {
        this.currentPerson = data;
      }
    });
  }

  logout() {
    this.authService.logout();
    this.router.navigate(['/sign-in']);
  }

}
