import { Component } from '@angular/core';
import { SwUpdate } from '@angular/service-worker';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'qr-tickets';

  constructor( updates: SwUpdate) {
    updates.available.subscribe(event => {
      updates.activateUpdate().then( () => {
        document.location.reload();
      });
    })
  }
}
