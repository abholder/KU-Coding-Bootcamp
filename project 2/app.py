# import necessary libraries
from sqlalchemy import func
import datetime as dt
import numpy as np
import pandas as pd

from flask import (
    Flask,
    render_template,
    jsonify,
    request,
    redirect)

from flask.ext.sqlalchemy import SQLAlchemy

#################################################
# Flask Setup
#################################################
app = Flask(__name__)

#################################################
# Database Setup
#################################################
app.config['SQLALCHEMY_DATABASE_URI'] = "sqlite:///db/Tickets.sqlite"

db = SQLAlchemy(app)


class Tickets(db.Model):
    __tablename__ = 'tickets'
    id = db.Column(db.Integer, primary_key=True)
    source = db.Column(db.String(255))
    department = db.Column(db.String(255))
    work_group = db.Column(db.String(255))
    request_type = db.Column(db.String(255))
    category = db.Column(db.String(255))
    type = db.Column(db.String(255))
    detail = db.Column(db.String(255))
    creation_date = db.Column(db.Integer)
    creation_time = db.Column(db.String(255))
    creation_month = db.Column(db.Integer)
    creation_year = db.Column(db.Integer)
    status = db.Column(db.String(255))
    exceeded_est_timeframe = db.Column(db.String(255))
    closed_date = db.Column(db.Integer)
    closed_month = db.Column(db.Integer)
    closed_year = db.Column(db.Integer)
    days_to_close = db.Column(db.Integer)
    street_address = db.Column(db.String(255))
    address_with_geocode = db.Column(db.String(255))
    zip_code = db.Column(db.String(255))
    neighborhood = db.Column(db.String(255))
    county = db.Column(db.String(255))
    council_district = db.Column(db.String(255))
    police_district = db.Column(db.String(255))
    parcel_id_no = db.Column(db.Integer)
    ycoordinate = db.Column(db.Integer)
    xcoordinate = db.Column(db.Integer)
    case_url = db.Column(db.String(255))
    days_open = db.Column(db.Integer)

    def __repr__(self):
        return '<Tickets %r>' % (self.name)


# Create database classes
@app.before_first_request
def setup():
    # Recreate database each time for demo
    # db.drop_all()
    db.create_all()

#################################################
# Flask Routes
#################################################


# Query the database and send the jsonified results
# @app.route("/data")
# def data():
#     sel = [func.strftime("%Y", Bigfoot.timestamp), func.count(Bigfoot.timestamp)]
#     results = db.session.query(*sel).\
#         group_by(func.strftime("%Y", Bigfoot.timestamp)).all()
#     df = pd.DataFrame(results, columns=['year', 'sightings'])
#     return jsonify(df.to_dict(orient="records"))


# create route that renders index.html template
@app.route("/")
def home():
    return render_template("index.html")


if __name__ == "__main__":
    app.run(debug=True)
