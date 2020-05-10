package controllers

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"

	"github.com/hiprofessional/qr-tickets/backend/api/models"
	"github.com/hiprofessional/qr-tickets/backend/api/responses"
	"github.com/hiprofessional/qr-tickets/backend/api/utils/formaterror"
)

func (server *Server) CreateTicket(w http.ResponseWriter, r *http.Request) {
	body, err := ioutil.ReadAll(r.Body)
	if err != nil {
		responses.ERROR(w, http.StatusUnprocessableEntity, err)
	}
	ticket := models.Ticket{}
	err = json.Unmarshal(body, &ticket)
	if err != nil {
		responses.ERROR(w, http.StatusUnprocessableEntity, err)
		return
	}
	ticket.Prepare()
	err = ticket.Validate()
	if err != nil {
		responses.ERROR(w, http.StatusUnprocessableEntity, err)
		return
	}
	ticketCreated, err := ticket.SaveTicket(server.DB)

	if err != nil {

		formattedError := formaterror.FormatError(err.Error())

		responses.ERROR(w, http.StatusInternalServerError, formattedError)
		return
	}
	w.Header().Set("Location", fmt.Sprintf("%s%s/%d", r.Host, r.RequestURI, ticketCreated.ID))
	responses.JSON(w, http.StatusCreated, ticketCreated)
}
