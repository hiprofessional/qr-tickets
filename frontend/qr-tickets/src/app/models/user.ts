import { Ticket } from './ticket';

export interface SignUpUser {
  Name: string;
  Email: string;
  Password: string;
}

export interface User {
  Id: number;
  Name: string;
  Email: string;
  Ticket?: Ticket;
}

export interface JwtResponse {
  userId: number;
  authorized: boolean;
  exp;
  userName: string;
  email: string;
}

export interface CurrentPerson {
  Name: string;
  Email: string;
  Id: number;
  Token: string;
}