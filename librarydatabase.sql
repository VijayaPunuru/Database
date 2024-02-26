create schema library;
use library;

create table library_member(member_id int primary key,first_name varchar(25),last_name varchar(25),email_address varchar(35),phone_number bigint,membership_level varchar(10),address_id int,foreign key(address_id) references address(address_id));
create table address(address_id int primary key,line1 varchar(30),line2 varchar(30),city varchar(20),state char(2),zip int);
create table checkout(id int primary key,isbn bigint,member_id int,checkout_date datetime,due_date datetime,is_returned boolean,foreign key(isbn) references book_isbn(isbn),foreign key(member_id) references library_member(member_id));
create table book_isbn(isbn bigint primary key,book_id int,foreign key(book_id) references book(book_id)) ;
create table book(book_id int primary key,title varchar(45),author_name varchar(50), year_published int,quantity int);

insert into book values(1,"Introduction to Java","Ganesh",2012,30);
insert into book values(2,"Numpy and Pandas","Divya",2010,30);
insert into book values(3,"Convolutional Neural Networks","Aishwarya",2011,30);
insert into book values(4,"Django MVT Frame work","Kumar",2014,30);
insert into book values(5,"Introuction to Flask Web Development","Shiva",2016,30);
insert into book values(6,"Graph Neural Networks","Shivani",2013,30);

insert into book_isbn(SELECT FLOOR(1000000000000 + RAND() * 9000000000000) AS random_isbn,1);
insert into book_isbn(SELECT FLOOR(1000000000000 + RAND() * 9000000000000) AS random_isbn,2);
insert into book_isbn(SELECT FLOOR(1000000000000 + RAND() * 9000000000000) AS random_isbn,3);
insert into book_isbn(SELECT FLOOR(1000000000000 + RAND() * 9000000000000) AS random_isbn,4);
insert into book_isbn(SELECT FLOOR(1000000000000 + RAND() * 9000000000000) AS random_isbn,5);
insert into book_isbn(SELECT FLOOR(1000000000000 + RAND() * 9000000000000) AS random_isbn,6);

insert into book_isbn(SELECT FLOOR(1000000000000 + RAND() * 9000000000000) AS random_isbn,6);
insert into book_isbn(SELECT FLOOR(1000000000000 + RAND() * 9000000000000) AS random_isbn,5);
insert into book_isbn(SELECT FLOOR(1000000000000 + RAND() * 9000000000000) AS random_isbn,4);
insert into book_isbn(SELECT FLOOR(1000000000000 + RAND() * 9000000000000) AS random_isbn,3);
insert into book_isbn(SELECT FLOOR(1000000000000 + RAND() * 9000000000000) AS random_isbn,2);
insert into book_isbn(SELECT FLOOR(1000000000000 + RAND() * 9000000000000) AS random_isbn,1);
insert into book_isbn(SELECT FLOOR(1000000000000 + RAND() * 9000000000000) AS random_isbn,1);
insert into book_isbn(SELECT FLOOR(1000000000000 + RAND() * 9000000000000) AS random_isbn,2);
insert into book_isbn(SELECT FLOOR(1000000000000 + RAND() * 9000000000000) AS random_isbn,3);
insert into book_isbn(SELECT FLOOR(1000000000000 + RAND() * 9000000000000) AS random_isbn,4);
insert into book_isbn(SELECT FLOOR(1000000000000 + RAND() * 9000000000000) AS random_isbn,5);
insert into book_isbn(SELECT FLOOR(1000000000000 + RAND() * 9000000000000) AS random_isbn,6);
insert into book_isbn(SELECT FLOOR(1000000000000 + RAND() * 9000000000000) AS random_isbn,1);
insert into book_isbn(SELECT FLOOR(1000000000000 + RAND() * 9000000000000) AS random_isbn,2);

insert into address values(11,"2206 west hickory","david street","denton",'TX',76201);
insert into address values(12,"1174 UC Denton","south bonnie brae street","denton",'TX',76202);
insert into address values(13,"1706 wood hill apartments","teasley lane","denton",'TX',76205);
insert into address values(14,"1555 Oaks Of Denton ","Fry Street","denton",'TX',76203);
insert into address values(15,"East Park Apartments","Welch Street","denton",'TX',76204);
insert into address values(16,"621 The Beverley At Denton","West University Drive","denton",'TX',76206);

insert into library_member values(401,"Aishwarya","Maroju","aishwaryamaroju5@gmail.com",4697020642,"silver",11);
insert into library_member values(402,"Nagasri","Maroju","nagasrimaroju5@gmail.com",4697020111,"silver",11);
insert into library_member values(403,"ramya","Ananthoju","ramyaananthoju15@gmail.com",4697020222,"gold",12);
insert into library_member values(404,"Kiran","Mandadi","kiranmandadi45@gmail.com",4697020333,"platinum",13);
insert into library_member values(405,"Vaishnav","Varma","vaishnavvarma77@gmail.com",4697020444,"platinum",14);
insert into library_member values(406,"Sridevi","Reddy","sridevireddy99@gmail.com",4697020555,"silver",15);
insert into library_member values(407,"Bhumi","Chowdary","bhumichowdary66@gmail.com",4697020666,"gold",16);
insert into library_member values(408,"Manish","Mallela","manasamallela89@gmail.com",4697020777,"silver",14);
insert into library_member values(411,"vijaya","lakshmi","vlp532at@gmail.com",4697120000,"platinum",14);
insert into library_member values(410,"Srinidhi","Ananthoju","sreenidhiananthoju333@gmail.com",4697020999,"silver",12);


-- find the member by name and mobile_number
SELECT * FROM library_member WHERE first_name ='vijaya' and phone_number='4697120000';

-- display all the members
SELECT * FROM library_member;

-- list all the books a member has checked out
SELECT b.title, b.author_name, b.year_published
FROM checkout c
JOIN book_isbn bi ON c.isbn = bi.isbn
JOIN book b ON bi.book_id = b.book_id
WHERE c.member_id = 411;

-- checkout a book for a given member and given book
insert into checkout values(2,4442736207919,411,now(),now()+ interval 30 day,false);

-- list all the checkouts that are due in two days
SELECT *
FROM checkout
WHERE DATE(due_date) = DATE_ADD(CURDATE(), INTERVAL 2 DAY);

-- list all the checkouts that are over due 
SELECT *
FROM checkout
WHERE DATE(due_date) < CURDATE() AND is_returned = FALSE;

-- list all the books that are checked out today
SELECT b.title, b.author_name
FROM checkout c
JOIN book_isbn bi ON c.isbn = bi.isbn
JOIN book b ON bi.book_id = b.book_id
WHERE DATE(c.checkout_date) = CURDATE();

-- display all isbns and their checkout status along with book information ( tital, author etc,.)
SELECT bi.isbn, c.is_returned, b.title, b.author_name
FROM checkout c
JOIN book_isbn bi ON c.isbn = bi.isbn
JOIN book b ON bi.book_id = b.book_id;

-- list available books and quantity that can be checked out

