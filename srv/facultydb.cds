using {com.nnrg.facultydb as db} from '../db/schema';
service FacultyDB {
    entity Faculty as projection on db.Faculty;
    entity Gender as projection on db.Gender;
    entity Courses as projection on db.Courses {
        @UI.Hidden: true
            ID,
            *
    };
    entity Languages as projection on db.Languages{
        @UI.Hidden: true
            ID,
            *
    };
    
}

annotate FacultyDB.Faculty with @odata.draft.enabled;
annotate FacultyDB.Courses with @odata.draft.enabled;
annotate FacultyDB.Languages with @odata.draft.enabled;


annotate FacultyDB.Faculty with {
    f_name @assert.format: '^[a-zA-Z]{2,}$';
    department @assert.format: '^[a-zA-Z]{2,}$';  
    acc_num @assert.format : '^[0-9]{10,10}$';
    //emailid   @assert.format: '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    //pan_no     @assert.format: '[A-Z]{5}[0-9]{4}[A-Z]{1}$';
    //telephone @assert.format: '^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$';
}

annotate FacultyDB.Languages with @ (
    
    UI.LineItem: [
        {
            Value :  code
        },
        {
            Value : description
        },
    ],
    UI.FieldGroup #LanguageInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                Value : code,
            },
            {
                
                Value : description,
            },
            ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'LangInfoFacet',
            Label : 'Language Information',
            Target : '@UI.FieldGroup#LanguageInformation',
        },
    ],
);

annotate FacultyDB.Courses with @ (
    
    UI.LineItem: [
        {
            Value :  code
        },
        {
            Value : description
        },
    ],
    UI.FieldGroup #CourseInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                Value : code,
            },
            {
                
                Value : description,
            },
            ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'CourseInfoFacet',
            Label : 'Course Information',
            Target : '@UI.FieldGroup#CourseInformation',
        },
    ],
    

);





annotate FacultyDB.Gender with @(
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value :  code
        },
        {
            $Type : 'UI.DataField',
            Value : description
        },
    ]

);




annotate FacultyDB.Faculty with @(
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value :  f_id
        },
        {
            $Type : 'UI.DataField',
            Value : f_name
        },
        {
            $Type : 'UI.DataField',
            Label: 'gender',
            Value : gender
        },
        {
            $Type : 'UI.DataField',
            Value : department
        },
        {
            $Type : 'UI.DataField',
            Value : salary
        },
        {
            $Type : 'UI.DataField',
            Value : experience
        },
        {
            $Type : 'UI.DataField',
            Value : acc_num
        },
        {
            Label: 'Course',
            Value: course_ID
        },
        {
            Label: 'Alumni',
            Value: is_alumni
        
        },


    ],
           UI.SelectionFields: [f_id, f_name,department,salary,experience,acc_num],
);

annotate FacultyDB.Faculty with @(
    UI.FieldGroup #FacultyInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : f_id,
            },
            {
                $Type : 'UI.DataField',
                
                Value : f_name,
            },
            {
                $Type : 'UI.DataField',
                Value : gender,
            },
            {
                $Type : 'UI.DataField',
                Value : department,
            },
            {
                $Type : 'UI.DataField',
                Value : salary,
            },
            {
                $Type : 'UI.DataField',
                Value : experience,
            },
            {
                $Type: 'UI.DataField',
                Value: acc_num
            },
            {
                $Type: 'UI.DataField',
                Value: course_ID
            }
          
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'FacultyInfoFacet',
            Label : 'Faculty Information',
            Target : '@UI.FieldGroup#FacultyInformation',
        },

        {
            $Type : 'UI.ReferenceFacet',
            ID : 'LanguageInfoFacet',
            Label : 'Language Information',
            Target : 'Languages/@UI.LineItem'
        }
    ],
    
);

annotate FacultyDB.Faculty.Languages with @(
    UI.LineItem:[
        {
            Label: 'Languages',
            Value: lang_ID
        },
       
    ],

     UI.FieldGroup #StudentLanguages : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                Value : lang_ID,
            }
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'LanguagesFacet',
            Label : 'Languages',
            Target : '@UI.FieldGroup#StudentLanguages',
        },
    ],  
);

annotate FacultyDB.Faculty.Languages with {
    lang @(
        Common.Text: lang.description,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Languages',
            CollectionPath : 'Languages',
            Parameters: [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : lang_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                },
            ]
        }
    )
};

annotate FacultyDB.Faculty with {
    gender @(
        Common.ValueListWithFixedValues:true,
        Common.ValueList: {
            Label :'Genders',
            CollectionPath:'Gender',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty:gender,
                    ValueListProperty:'code'
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty:'description'
                }

            ]
        }
    );
    course @(
        Common.Text: course.description,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues:true,
        Common.ValueList: {
            Label :'Courses',
            CollectionPath:'Courses',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty:course_ID,
                    ValueListProperty:'ID'
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty:'code'
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty:'description'
                }

            ]
        }
    );

}