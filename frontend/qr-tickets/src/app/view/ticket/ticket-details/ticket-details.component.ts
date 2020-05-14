import { Component, OnInit, Input } from '@angular/core';
import { FormGroup } from '@angular/forms';
import { TicketService } from 'src/app/core/services/ticket.service';
import { Ticket } from 'src/app/models/ticket';

@Component({
  selector: 'app-ticket-details',
  templateUrl: './ticket-details.component.html',
  styleUrls: ['./ticket-details.component.scss']
})
export class TicketDetailsComponent implements OnInit {
  @Input() ticketForm: FormGroup;
  @Input() userId: number;
  constructor(
    private ticketService: TicketService
  ) { }

  ngOnInit(): void {
  }

  get image() {
    return 'data:image/png;base64,' + this.ticketForm.get('Image').value;
  }

  get id() {
    return this.ticketForm.get('Id').value;
  }

  createTicket() {
    const ticket: Ticket = {
      UserId: this.userId,
      Id: 0
    }

    this.ticketService.createTicket(ticket).subscribe(data => {
      this.ticketForm.patchValue(data);
    })
  }
}
