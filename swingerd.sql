SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS ApplyList;
DROP TABLE IF EXISTS Chatting;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS ClassInfo;
DROP TABLE IF EXISTS WishList;
DROP TABLE IF EXISTS Class;
DROP TABLE IF EXISTS License;
DROP TABLE IF EXISTS User;




/* Create Tables */

CREATE TABLE ApplyList
(
	applyno int(10) NOT NULL,
	userid varchar(10) NOT NULL,
	classid int(10) NOT NULL,
	-- 최대 8회차까지
	classno int(10) NOT NULL COMMENT '최대 8회차까지',
	classseq int(2) NOT NULL,
	PRIMARY KEY (applyno)
);


CREATE TABLE Chatting
(
	roomno int(10) NOT NULL,
	talkno int(10) NOT NULL,
	userid varchar(10) NOT NULL,
	classid int(10) NOT NULL,
	chat varchar(300),
	chatdate datetime,
	PRIMARY KEY (roomno, talkno)
);


CREATE TABLE Class
(
	classid int(10) NOT NULL,
	userid varchar(10) NOT NULL,
	location1 varchar(20),
	location2 varchar(20),
	category int(1),
	type int(1),
	maxtutee int(10),
	subject varchar(30),
	coverimg varchar(200),
	price int(10),
	time int(10),
	totaltime int(10),
	totalprice int(10),
	tutorintro varchar(300),
	classintro varchar(300),
	level int(1),
	readcnt int(10),
	-- 등록진행 - 1 /승인대기-2 /반려 -3 /승인완료 - 4
	state int(1) COMMENT '등록진행 - 1 /승인대기-2 /반려 -3 /승인완료 - 4',
	regdate datetime,
	PRIMARY KEY (classid)
);


CREATE TABLE ClassInfo
(
	classid int(10) NOT NULL,
	-- 최대 8회차까지
	classno int(10) NOT NULL COMMENT '최대 8회차까지',
	classseq int(2) NOT NULL,
	date date,
	starttime time,
	endtime time,
	place varchar(30),
	title varchar(30),
	curri varchar(100),
	PRIMARY KEY (classid, classno, classseq)
);


CREATE TABLE License
(
	lcno int(2) NOT NULL,
	userid varchar(10) NOT NULL,
	lctitle varchar(30),
	lcfile varchar(200),
	PRIMARY KEY (lcno)
);


CREATE TABLE Review
(
	reviewno int(10) NOT NULL,
	userid varchar(10) NOT NULL,
	classid int(10) NOT NULL,
	-- 최대 8회차까지
	classno int(10) NOT NULL COMMENT '최대 8회차까지',
	classseq int(2) NOT NULL,
	content varchar(300),
	star double,
	regdate datetime,
	PRIMARY KEY (reviewno, userid, classid, classno)
);


CREATE TABLE User
(
	userid varchar(10) NOT NULL,
	pass varchar(10),
	name varchar(10),
	email varchar(30),
	file varchar(200),
	kbn int(1),
	nickname varchar(10),
	edulevel int(1),
	school varchar(20),
	major varchar(20),
	edufile varchar(200),
	PRIMARY KEY (userid)
);


CREATE TABLE WishList
(
	userid varchar(10) NOT NULL,
	classid int(10) NOT NULL,
	PRIMARY KEY (userid, classid)
);



/* Create Foreign Keys */

ALTER TABLE Chatting
	ADD FOREIGN KEY (classid)
	REFERENCES Class (classid)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE ClassInfo
	ADD FOREIGN KEY (classid)
	REFERENCES Class (classid)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE WishList
	ADD FOREIGN KEY (classid)
	REFERENCES Class (classid)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE ApplyList
	ADD FOREIGN KEY (classid, classno, classseq)
	REFERENCES ClassInfo (classid, classno, classseq)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE Review
	ADD FOREIGN KEY (classid, classno, classseq)
	REFERENCES ClassInfo (classid, classno, classseq)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE ApplyList
	ADD FOREIGN KEY (userid)
	REFERENCES User (userid)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE Chatting
	ADD FOREIGN KEY (userid)
	REFERENCES User (userid)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE Class
	ADD FOREIGN KEY (userid)
	REFERENCES User (userid)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE License
	ADD FOREIGN KEY (userid)
	REFERENCES User (userid)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE Review
	ADD FOREIGN KEY (userid)
	REFERENCES User (userid)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE WishList
	ADD FOREIGN KEY (userid)
	REFERENCES User (userid)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



