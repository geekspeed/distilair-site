DROP TABLE IF EXISTS ticketFlight;
DROP TABLE IF EXISTS ticket;
DROP TABLE IF EXISTS transaction;
DROP TABLE IF EXISTS traveler;
DROP TABLE IF EXISTS flightSearchR;
DROP TABLE IF EXISTS flight;
DROP TABLE IF EXISTS profile;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS flightSearchR;

CREATE TABLE flightSearchR (
	startId INT,
	endId INT,
	path VARCHAR(256),
	userSession VARCHAR(40),
	INDEX (startId),
	INDEX (endId),
	INDEX (path),
	INDEX (userSession)
);


CREATE TABLE user (
	userId INT UNSIGNED NOT NULL AUTO_INCREMENT,
	email VARCHAR(64) NOT NULL,
	password CHAR(128) NOT NULL,
	salt CHAR(64) NOT NULL,
	authToken CHAR(32),
	PRIMARY KEY(userId),
	UNIQUE(email),
	INDEX(authToken)
);

CREATE TABLE profile (
	profileId INT UNSIGNED NOT NULL AUTO_INCREMENT,
	userId INT UNSIGNED NOT NULL,
	userFirstName VARCHAR(75) NOT NULL,
	userMiddleName VARCHAR(75),
	userLastName VARCHAR(75) NOT NULL,
	dateOfBirth DATETIME NOT NULL,
	customerToken VARCHAR(130),
	PRIMARY KEY (profileId),
	UNIQUE (userId),
	FOREIGN KEY (userId) REFERENCES user (userId)
);

CREATE TABLE flight (
	flightId          INT UNSIGNED NOT NULL AUTO_INCREMENT,
	origin            VARCHAR(20)  NOT NULL,
	destination       VARCHAR(20)  NOT NULL,
	duration          TIME         NOT NULL,
	departureDateTime DATETIME     NOT NULL,
	arrivalDateTime   DATETIME     NOT NULL,
	flightNumber      VARCHAR(15)  NOT NULL,
	price             DECIMAL(10,2)  NOT NULL,
	totalSeatsOnPlane INT UNSIGNED NOT NULL,

	INDEX (origin),
	INDEX (destination),
	INDEX (departureDateTime),
	INDEX (arrivalDateTime),
	INDEX (totalSeatsOnPlane),

	PRIMARY KEY (flightId)
);

CREATE TABLE traveler (
	travelerId INT UNSIGNED NOT NULL AUTO_INCREMENT,
	travelerFirstName VARCHAR(75) NOT NULL,
	travelerMiddleName VARCHAR(75),
	travelerLastName VARCHAR(75) NOT NULL,
	travelerDateOfBirth DATETIME NOT NULL,
	profileId INT UNSIGNED NOT NULL,
	INDEX(profileId),
	PRIMARY KEY (travelerId),
	FOREIGN KEY (profileId) REFERENCES profile(profileId)

);

CREATE TABLE transaction (
	transactionId INT UNSIGNED NOT NULL AUTO_INCREMENT,
	profileId INT UNSIGNED NOT NULL,
	amount INT UNSIGNED,
	dateApproved BIGINT,
	cardToken VARCHAR(124),
	stripeToken VARCHAR(124),
	PRIMARY KEY (transactionId),
	INDEX(profileId),
	FOREIGN KEY (profileId) REFERENCES profile (profileId)

);

CREATE TABLE ticket (
	ticketId INT UNSIGNED NOT NULL AUTO_INCREMENT,
	confirmationNumber VARCHAR(30),
	price DECIMAL(5,2) UNSIGNED,
	status VARCHAR(30),
	profileId INT UNSIGNED NOT NULL,
	travelerId INT UNSIGNED NOT NULL,
	transactionId INT UNSIGNED NOT NULL,
	UNIQUE (confirmationNumber),
	INDEX(profileId),
	INDEX(travelerId),
	PRIMARY KEY (ticketId),
	FOREIGN KEY (profileId) REFERENCES profile (profileId),
	FOREIGN KEY (travelerId) REFERENCES traveler (travelerId),
	FOREIGN KEY (transactionId) REFERENCES transaction (transactionId)
);

CREATE TABLE ticketFlight (
	flightId INT UNSIGNED NOT NULL,
	ticketId INT UNSIGNED NOT NULL,
	INDEX(flightId),
	INDEX(ticketId),
	PRIMARY KEY (flightId,ticketId),
	FOREIGN KEY (flightId) REFERENCES flight(flightId),
	FOREIGN KEY (ticketId) REFERENCES ticket(ticketId)

);

