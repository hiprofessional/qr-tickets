package controllers

import "github.com/hiprofessional/qr-tickets/backend/api/middlewares"

func (s *Server) initializeRoutes() {

	// Login Route
	s.Router.HandleFunc("/login", middlewares.SetMiddlewareJSON(s.Login)).Methods("POST")

	// Sign up Route
	s.Router.HandleFunc("/signup", middlewares.SetMiddlewareJSON(s.SignUp)).Methods("POST")

	//Users routes
	s.Router.HandleFunc("/users", middlewares.SetMiddlewareJSON(middlewares.SetMiddlewareAuthentication(s.CreateUser))).Methods("POST")
	s.Router.HandleFunc("/users", middlewares.SetMiddlewareJSON(middlewares.SetMiddlewareAuthentication(s.GetUsers))).Methods("GET")
	s.Router.HandleFunc("/users/{id}", middlewares.SetMiddlewareJSON(middlewares.SetMiddlewareAuthentication(s.GetUser))).Methods("GET")

	//Search users
	s.Router.HandleFunc("/search", middlewares.SetMiddlewareJSON(middlewares.SetMiddlewareAuthentication(s.SearchUsers))).Queries("UserId", "{UserId}", "TicketId", "{TicketId}").Methods("GET")

	//Tickets routes
	s.Router.HandleFunc("/tickets", middlewares.SetMiddlewareJSON(middlewares.SetMiddlewareAuthentication(s.CreateTicket))).Methods("POST")

}
