namespace com.satinfotech.studentdb;
using { managed,cuid } from '@sap/cds/common';

@assert.unique : {
    stid : [stid]
}
entity Student: cuid,managed {
    @title: 'Student ID'
    stid: String(5);
    @title: 'Gender'
    gender: String(1);
    virtual gender_description : String(10) @Core.Computed;
    @title: 'First Name'
    first_name: String(40) @mandatory;
    @title: 'Last Name'
    last_name: String(40) @mandatory;
    @title: 'Email ID'
    email_id: String(100) @mandatory;
     @title:'PAN NO'
    pan_no:String(30) @mandatory;
    @title:'MOBILE'
    ph_no: String(50) @mandatory;
    @title: 'Date of Birth'
    dob: Date @mandatory;
    @title : 'Course'
    course : Association to Courses;
     @title: 'Languages Known'
    Languages: Composition of many {
        key ID : UUID;
        lang : Association to Languages;
    }
    @title: 'Age'
    virtual age: Integer @Core.Computed;
    @title : 'Is Alumni'
    is_alumni : Boolean default false;
}

@cds.persistence.skip
entity Gender {
    @title: 'code'
    key code: String(1);
    @title: 'Description'
    description: String(10);
}

entity Courses : cuid, managed {
    @title: 'Code'
    code: String(3);
    @title: 'Description'
    description: String(50);
    @title: 'Books'
     Books: Composition of many {
          key ID: UUID;
       book: Association to Books;
     }
     @title : 'book Count'
     BookCount : Integer @Core.Computed;
     @title: 'Number of Students'
     virtual numberOfStudents: Integer @Core.Computed;
}

entity Languages: cuid, managed {
    @title: 'Code'
    code: String(2);
    @title: 'Description'
    description: String(20);
}

entity Books: cuid, managed {
     @title: 'Code'
     code: String(10);
     @title: 'Description'
     description: String(50);
}