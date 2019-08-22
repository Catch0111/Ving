package service

import (
	"context"
	"os"
	"time"

	"github.com/b3log/gulu"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"go.mongodb.org/mongo-driver/mongo/readpref"
)

// Logger
var logger = gulu.Log.NewLogger(os.Stdout)

// ConnectDB creates a new wrapper for the mongo-go-driver.
func ConnectDB(connection, dbname string) (*MovieDatabase, error) {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	client, err := mongo.Connect(ctx, options.Client().ApplyURI(connection))
	if err != nil {
		return nil, err
	}
	ctxping, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	err = client.Ping(ctxping, readpref.Primary())
	if err != nil {
		return nil, err
	}
	db := client.Database(dbname)
	return &MovieDatabase{DB: db, Client: client, Context: ctx}, nil
}

// MovieDatabase is a wrapper for the mongo-go-driver.
type MovieDatabase struct {
	DB      *mongo.Database
	Client  *mongo.Client
	Context context.Context
}

// Close closes the mongo-go-driver connection.
func (d *MovieDatabase) Close() {
	d.Client.Disconnect(d.Context)
}
