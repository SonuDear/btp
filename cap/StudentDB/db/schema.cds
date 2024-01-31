namespace com.satinfotech.studentdb;

@assert.unique : {
    stid : [stid]
}
entity Student {
    key ID : UUID;
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
    @title: 'Age'
    virtual age: Integer @Core.Computed;
}

@cds.persistence.skip
entity Gender {
    @title: 'code'
    key code: String(1);
    @title: 'Description'
    description: String(10);
}