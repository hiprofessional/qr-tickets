package models

import (
	"encoding/base64"
	"errors"
	"fmt"
	"time"

	"github.com/jinzhu/gorm"
	"github.com/skip2/go-qrcode"
)

type Ticket struct {
	ID        uint32    `gorm:"primary_key;auto_increment" json:"Id"`
	UserID    uint32    `json:"UserId"`
	CreatedAt time.Time `gorm:"default:CURRENT_TIMESTAMP" json:"CreatedAt"`
	Image     string    `gorm:"-" json:"Image"`
}

func (t *Ticket) Prepare() {
	t.ID = 0
	t.CreatedAt = time.Now()
}

func (t *Ticket) Validate() error {
	if t.UserID == 0 {
		return errors.New("Required UserID")
	}
	return nil
}

func (t *Ticket) SaveTicket(db *gorm.DB) (*Ticket, error) {
	var err error
	err = db.Debug().Create(&t).Error
	if err != nil {
		return &Ticket{}, err
	}
	t.GetQRValue()
	return t, nil
}

func (t *Ticket) GetQRValue() {
	valueForQr := fmt.Sprint("UserId=", t.UserID, ";TicketId=", t.ID)
	png, err := qrcode.Encode(valueForQr, qrcode.Medium, 256)
	if err != nil {
		return
	}
	encodedFile := base64.StdEncoding.EncodeToString(png)
	t.Image = encodedFile
}
