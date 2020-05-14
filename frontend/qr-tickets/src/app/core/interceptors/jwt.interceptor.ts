import { Injectable } from '@angular/core';
import {
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpInterceptor
} from '@angular/common/http';
import { Observable } from 'rxjs';
import { AuthenticationService } from '../services/authentication.service';

@Injectable()
export class JwtInterceptor implements HttpInterceptor {

  constructor(
    private authService: AuthenticationService
  ) {}

  intercept(request: HttpRequest<unknown>, next: HttpHandler): Observable<HttpEvent<unknown>> {
    const currentPerson = this.authService.getCurrentPerson();
    if (currentPerson && currentPerson.value && currentPerson.value.Token) {
      request = request.clone({
        setHeaders: {
          Authorization: `Bearer ${currentPerson.value.Token}`
        }
      })
    }
    return next.handle(request);
  }
}
