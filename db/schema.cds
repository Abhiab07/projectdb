namespace com.nnrg.facultydb;
using { managed,cuid} from '@sap/cds/common';
@assert.unique:{
    f_id:[f_id]
}
entity Faculty: cuid, managed {
    key ID: UUID;
    @title:'Faculty ID'
    f_id:String(10) ;
    @title: 'Gender'
    gender:String(1);//assiosion to
    @title:'Faculty Name'
    f_name:String(30) @mandatory;
    @title:'Department'
    department:String(20)  @mandatory;
    @title: 'Courses'
    course: Association to Courses;
    @title:'salary'
    salary:String(10)  @mandatory;
    @title:'Experience'
    experience:String(10)  @mandatory;
    @title: 'Account Number'
    acc_num:String(10) @mandatory;
    @title: 'Languages Known'
    Languages: Composition of many {
        key ID: UUID;
        lang: Association to Languages;
    };
    @title : 'Is Alumni'
    is_alumni : Boolean default false;
}

@cds.persistence.skip
entity Gender {
    @title: 'code'
    key code:String(1);
    @title: 'description'
    description:String(10);
}

entity Courses: cuid,managed {
    @title: 'code'
    code:String(10);
    @title: 'description'
    description:String(40);
}

entity Languages: cuid, managed {
    @title: 'code'
    code:String(2);
    @title: 'Description'
    description: String(20);

}