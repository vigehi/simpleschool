
CREATE TABLE student (
    stu_id     serial PRIMARY KEY,
    org_id                    integer references orgs,
    stu_fname varchar(20)  NOT NULL,
    stu_lname varchar(20)  NOT NULL
);
CREATE INDEX student_org_id ON student(org_id);
CREATE TABLE department ( 
    dep_code   serial PRIMARY KEY,
     org_id                    integer references orgs,
    dep_name varchar(40) NOT NULL UNIQUE
);

CREATE TABLE instructor ( 
    ins_id     serial PRIMARY KEY,
     org_id                    integer references orgs,
    ins_fname varchar(20) NOT NULL,
    ins_lname varchar(20) NOT NULL,
    dep_code  integer  REFERENCES department(dep_code)
);

CREATE TABLE location (
    loc_code      serial PRIMARY KEY,
     org_id                    integer references orgs,
    loc_name    varchar(40) NOT NULL,
    loc_country varchar(2)  NOT NULL
);

CREATE TABLE course ( 
    crs_code          serial PRIMARY KEY,
     org_id                    integer references orgs,
    crs_title       varchar(100) NOT NULL,
    crs_credits     integer      NOT NULL,
    dep_code        integer  REFERENCES department(dep_code),
    crs_description varchar(255) NOT NULL
);

CREATE TABLE section (
    sec_id     serial PRIMARY KEY,
     org_id                    integer references orgs,
    sec_term varchar(8)  NOT NULL,
    sec_bldg varchar(6),
    sec_room varchar(4),
    sec_time varchar(10),
    crs_code integer REFERENCES course(crs_code),
    loc_code integer  REFERENCES location(loc_code),
    ins_id   integer  REFERENCES instructor(ins_id)
);

CREATE TABLE enrollment (
     org_id                    integer references orgs,
    stu_id     integer    REFERENCES student(stu_id),
    sec_id     integer      REFERENCES section(sec_id),
    grade_code varchar(2),
    PRIMARY KEY (stu_id, sec_id)
);

CREATE TABLE prerequisite ( 
     org_id                    integer references orgs,
    crs_code     integer REFERENCES course(crs_code),
    crs_requires integer REFERENCES course(crs_code),
    PRIMARY KEY (crs_code, crs_requires)
);

CREATE TABLE qualified (
     org_id                    integer references orgs,
    ins_id  integer REFERENCES instructor(ins_id),
    crs_code integer REFERENCES course(crs_code),
    PRIMARY KEY (ins_id, crs_code)
);