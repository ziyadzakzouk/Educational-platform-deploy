using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Course_station.Migrations
{
    /// <inheritdoc />
    public partial class AddEmailAndPasswordToLearner : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Badge",
                columns: table => new
                {
                    BadgeID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    title = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: true),
                    description = table.Column<string>(type: "varchar(200)", unicode: false, maxLength: 200, nullable: true),
                    criteria = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: true),
                    points = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Badge__1918237C4A82E7F9", x => x.BadgeID);
                });

            migrationBuilder.CreateTable(
                name: "Course",
                columns: table => new
                {
                    Course_ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    title = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: true),
                    description = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true),
                    diff_level = table.Column<string>(type: "varchar(8)", unicode: false, maxLength: 8, nullable: true),
                    credit_point = table.Column<int>(type: "int", nullable: true),
                    learning_objective = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Course__37E005FB479EE564", x => x.Course_ID);
                });

            migrationBuilder.CreateTable(
                name: "Instructor",
                columns: table => new
                {
                    Instructor_ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Instructor_name = table.Column<string>(type: "varchar(20)", unicode: false, maxLength: 20, nullable: true),
                    latest_qualification = table.Column<string>(type: "varchar(20)", unicode: false, maxLength: 20, nullable: true),
                    expertise_area = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: true),
                    email = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Instruct__DD4B9A8ADBF15F10", x => x.Instructor_ID);
                });

            migrationBuilder.CreateTable(
                name: "Leaderboard",
                columns: table => new
                {
                    BoardID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    season = table.Column<string>(type: "varchar(20)", unicode: false, maxLength: 20, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Leaderbo__F9646BD254AD5C0D", x => x.BoardID);
                });

            migrationBuilder.CreateTable(
                name: "Learner",
                columns: table => new
                {
                    Learner_ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    first_name = table.Column<string>(type: "varchar(20)", unicode: false, maxLength: 20, nullable: true),
                    last_name = table.Column<string>(type: "varchar(20)", unicode: false, maxLength: 20, nullable: true),
                    birthday = table.Column<DateOnly>(type: "date", nullable: true),
                    gender = table.Column<string>(type: "varchar(10)", unicode: false, maxLength: 10, nullable: true),
                    country = table.Column<string>(type: "varchar(20)", unicode: false, maxLength: 20, nullable: true),
                    cultural_background = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: true),
                    email = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: false),
                    password = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Learner__3DE277FF157AE6B6", x => x.Learner_ID);
                });

            migrationBuilder.CreateTable(
                name: "Learning_goal",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    status = table.Column<string>(type: "varchar(20)", unicode: false, maxLength: 20, nullable: false),
                    deadline = table.Column<DateOnly>(type: "date", nullable: false),
                    description = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Learning__3214EC2756A1DAB0", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Notification",
                columns: table => new
                {
                    Notification_ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    time_stamp = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())"),
                    message = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true),
                    urgency = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: true),
                    readstatus = table.Column<bool>(type: "bit", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Notifica__8C1160B58591F297", x => x.Notification_ID);
                });

            migrationBuilder.CreateTable(
                name: "Quest",
                columns: table => new
                {
                    QuestID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    difficulty_level = table.Column<int>(type: "int", nullable: true),
                    criteria = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: true),
                    description = table.Column<string>(type: "varchar(200)", unicode: false, maxLength: 200, nullable: true),
                    title = table.Column<string>(type: "varchar(60)", unicode: false, maxLength: 60, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Quest__B6619ACB864E1E60", x => x.QuestID);
                });

            migrationBuilder.CreateTable(
                name: "Reward",
                columns: table => new
                {
                    RewardID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    value = table.Column<int>(type: "int", nullable: true),
                    description = table.Column<string>(type: "varchar(200)", unicode: false, maxLength: 200, nullable: true),
                    type = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Reward__82501599B39290AF", x => x.RewardID);
                });

            migrationBuilder.CreateTable(
                name: "Survey",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Title = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Survey__3214EC277BEB44F7", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "CoursePrerequisites",
                columns: table => new
                {
                    Course_ID = table.Column<int>(type: "int", nullable: false),
                    prerequisite = table.Column<string>(type: "varchar(250)", unicode: false, maxLength: 250, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__CoursePr__A33A4ED1E66E9C8B", x => new { x.Course_ID, x.prerequisite });
                    table.ForeignKey(
                        name: "FK__CoursePre__Cours__47DBAE45",
                        column: x => x.Course_ID,
                        principalTable: "Course",
                        principalColumn: "Course_ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Module",
                columns: table => new
                {
                    Module_ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Course_ID = table.Column<int>(type: "int", nullable: false),
                    title = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: true),
                    difficulty_level = table.Column<string>(type: "varchar(8)", unicode: false, maxLength: 8, nullable: true),
                    contentURL = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Module__BE9AE0776D951244", x => new { x.Module_ID, x.Course_ID });
                    table.ForeignKey(
                        name: "FK__Module__Course_I__4AB81AF0",
                        column: x => x.Course_ID,
                        principalTable: "Course",
                        principalColumn: "Course_ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Teaches",
                columns: table => new
                {
                    Instructor_ID = table.Column<int>(type: "int", nullable: false),
                    Course_ID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Teaches__7E359AD5C2111E9F", x => new { x.Instructor_ID, x.Course_ID });
                    table.ForeignKey(
                        name: "FK__Teaches__Course___76969D2E",
                        column: x => x.Course_ID,
                        principalTable: "Course",
                        principalColumn: "Course_ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK__Teaches__Instruc__75A278F5",
                        column: x => x.Instructor_ID,
                        principalTable: "Instructor",
                        principalColumn: "Instructor_ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Achievement",
                columns: table => new
                {
                    AchievementID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    LearnerID = table.Column<int>(type: "int", nullable: true),
                    BadgeID = table.Column<int>(type: "int", nullable: true),
                    Description = table.Column<string>(type: "text", nullable: true),
                    DateEarned = table.Column<DateOnly>(type: "date", nullable: false),
                    Type = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Achievem__276330E068F35568", x => x.AchievementID);
                    table.ForeignKey(
                        name: "FK__Achieveme__Badge__30C33EC3",
                        column: x => x.BadgeID,
                        principalTable: "Badge",
                        principalColumn: "BadgeID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK__Achieveme__Learn__2FCF1A8A",
                        column: x => x.LearnerID,
                        principalTable: "Learner",
                        principalColumn: "Learner_ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Course_Enrollment",
                columns: table => new
                {
                    Enrollment_ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Learner_ID = table.Column<int>(type: "int", nullable: true),
                    Course_ID = table.Column<int>(type: "int", nullable: true),
                    enrollment_date = table.Column<DateOnly>(type: "date", nullable: true),
                    completion_date = table.Column<DateOnly>(type: "date", nullable: true),
                    status = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Course_E__4365BD6AD0C13685", x => x.Enrollment_ID);
                    table.ForeignKey(
                        name: "FK__Course_En__Cours__571DF1D5",
                        column: x => x.Course_ID,
                        principalTable: "Course",
                        principalColumn: "Course_ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK__Course_En__Learn__5629CD9C",
                        column: x => x.Learner_ID,
                        principalTable: "Learner",
                        principalColumn: "Learner_ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "LearningPrefrences",
                columns: table => new
                {
                    Learner_ID = table.Column<int>(type: "int", nullable: false),
                    prefrences = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Learning__7B1D3263133AC949", x => new { x.Learner_ID, x.prefrences });
                    table.ForeignKey(
                        name: "FK__LearningP__Learn__3D5E1FD2",
                        column: x => x.Learner_ID,
                        principalTable: "Learner",
                        principalColumn: "Learner_ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "PersonalProfile",
                columns: table => new
                {
                    Learner_ID = table.Column<int>(type: "int", nullable: false),
                    profileID = table.Column<int>(type: "int", nullable: false),
                    PreferedContent_type = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: true),
                    emotionalState = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: true),
                    personality_type = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Personal__BA3661C6CC87238E", x => new { x.Learner_ID, x.profileID });
                    table.ForeignKey(
                        name: "FK__PersonalP__Learn__403A8C7D",
                        column: x => x.Learner_ID,
                        principalTable: "Learner",
                        principalColumn: "Learner_ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Ranking",
                columns: table => new
                {
                    BoardID = table.Column<int>(type: "int", nullable: false),
                    LearnerID = table.Column<int>(type: "int", nullable: false),
                    CourseID = table.Column<int>(type: "int", nullable: true),
                    rank = table.Column<int>(type: "int", nullable: false),
                    total_points = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Ranking__4F1ED41D4273594D", x => new { x.BoardID, x.LearnerID });
                    table.ForeignKey(
                        name: "FK__Ranking__BoardID__3864608B",
                        column: x => x.BoardID,
                        principalTable: "Leaderboard",
                        principalColumn: "BoardID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK__Ranking__CourseI__3A4CA8FD",
                        column: x => x.CourseID,
                        principalTable: "Course",
                        principalColumn: "Course_ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK__Ranking__Learner__395884C4",
                        column: x => x.LearnerID,
                        principalTable: "Learner",
                        principalColumn: "Learner_ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Skills",
                columns: table => new
                {
                    Learner_ID = table.Column<int>(type: "int", nullable: false),
                    skill = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Skills__9E1255A04DD855D7", x => new { x.Learner_ID, x.skill });
                    table.ForeignKey(
                        name: "FK__Skills__Learner___3A81B327",
                        column: x => x.Learner_ID,
                        principalTable: "Learner",
                        principalColumn: "Learner_ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "LearnersGoals",
                columns: table => new
                {
                    GoalID = table.Column<int>(type: "int", nullable: false),
                    LearnerID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Learners__3C3540FE247F3690", x => new { x.GoalID, x.LearnerID });
                    table.ForeignKey(
                        name: "FK__LearnersG__GoalI__3F115E1A",
                        column: x => x.GoalID,
                        principalTable: "Learning_goal",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK__LearnersG__Learn__40058253",
                        column: x => x.LearnerID,
                        principalTable: "Learner",
                        principalColumn: "Learner_ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "RecivedNotfy",
                columns: table => new
                {
                    Learner_ID = table.Column<int>(type: "int", nullable: false),
                    Notification_ID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__RecivedN__752361F4E8319A6D", x => new { x.Learner_ID, x.Notification_ID });
                    table.ForeignKey(
                        name: "FK__RecivedNo__Learn__7D439ABD",
                        column: x => x.Learner_ID,
                        principalTable: "Learner",
                        principalColumn: "Learner_ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK__RecivedNo__Notif__7E37BEF6",
                        column: x => x.Notification_ID,
                        principalTable: "Notification",
                        principalColumn: "Notification_ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Collaborative",
                columns: table => new
                {
                    QuestID = table.Column<int>(type: "int", nullable: false),
                    Deadline = table.Column<DateOnly>(type: "date", nullable: true),
                    Max_Num_Participants = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Collabor__B6619ACBCA827253", x => x.QuestID);
                    table.ForeignKey(
                        name: "FK__Collabora__Quest__123EB7A3",
                        column: x => x.QuestID,
                        principalTable: "Quest",
                        principalColumn: "QuestID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Skill_Mastery",
                columns: table => new
                {
                    QuestID = table.Column<int>(type: "int", nullable: false),
                    Skill = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Skill_Ma__CF6E15970A8FE247", x => new { x.QuestID, x.Skill });
                    table.UniqueConstraint("AK_Skill_Mastery_QuestID", x => x.QuestID);
                    table.ForeignKey(
                        name: "FK__Skill_Mas__Quest__0F624AF8",
                        column: x => x.QuestID,
                        principalTable: "Quest",
                        principalColumn: "QuestID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "QuestReward",
                columns: table => new
                {
                    QuestID = table.Column<int>(type: "int", nullable: false),
                    RewardID = table.Column<int>(type: "int", nullable: false),
                    LearnerID = table.Column<int>(type: "int", nullable: false),
                    timeEarned = table.Column<DateTime>(type: "datetime", nullable: true, defaultValueSql: "(getdate())")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__QuestRew__C523306E95866F17", x => new { x.QuestID, x.RewardID, x.LearnerID });
                    table.ForeignKey(
                        name: "FK__QuestRewa__Learn__0B91BA14",
                        column: x => x.LearnerID,
                        principalTable: "Learner",
                        principalColumn: "Learner_ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK__QuestRewa__Quest__09A971A2",
                        column: x => x.QuestID,
                        principalTable: "Quest",
                        principalColumn: "QuestID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK__QuestRewa__Rewar__0A9D95DB",
                        column: x => x.RewardID,
                        principalTable: "Reward",
                        principalColumn: "RewardID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "SurveyQuestions",
                columns: table => new
                {
                    SurveyID = table.Column<int>(type: "int", nullable: false),
                    Question = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__SurveyQu__23FB983BDB0F3FCB", x => new { x.SurveyID, x.Question });
                    table.ForeignKey(
                        name: "FK__SurveyQue__Surve__25518C17",
                        column: x => x.SurveyID,
                        principalTable: "Survey",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Assessment",
                columns: table => new
                {
                    Assessment_ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Module_ID = table.Column<int>(type: "int", nullable: true),
                    Course_ID = table.Column<int>(type: "int", nullable: true),
                    type = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: true),
                    totalMarks = table.Column<int>(type: "int", nullable: true),
                    passingMarks = table.Column<int>(type: "int", nullable: true),
                    criteria = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true),
                    weightage = table.Column<int>(type: "int", nullable: true),
                    description = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true),
                    title = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Assessme__6B3C1D927D3DADAF", x => x.Assessment_ID);
                    table.ForeignKey(
                        name: "FK__Assessment__5AEE82B9",
                        columns: x => new { x.Module_ID, x.Course_ID },
                        principalTable: "Module",
                        principalColumns: new[] { "Module_ID", "Course_ID" },
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ContentLibrary",
                columns: table => new
                {
                    Lib_ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Module_ID = table.Column<int>(type: "int", nullable: true),
                    Course_ID = table.Column<int>(type: "int", nullable: true),
                    title = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: true),
                    description = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true),
                    metaData = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true),
                    type = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: true),
                    contentURL = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__ContentL__4151D01392B24AE4", x => x.Lib_ID);
                    table.ForeignKey(
                        name: "FK__ContentLibrary__534D60F1",
                        columns: x => new { x.Module_ID, x.Course_ID },
                        principalTable: "Module",
                        principalColumns: new[] { "Module_ID", "Course_ID" },
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Discussion_forum",
                columns: table => new
                {
                    forumID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Course_ID = table.Column<int>(type: "int", nullable: true),
                    Module_ID = table.Column<int>(type: "int", nullable: true),
                    title = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: true),
                    last_active = table.Column<DateTime>(type: "datetime", nullable: true),
                    timestamp = table.Column<DateTime>(type: "datetime", nullable: true),
                    description = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Discussi__BBA7A440B88B57A0", x => x.forumID);
                    table.ForeignKey(
                        name: "FK__Discussion_forum__208CD6FA",
                        columns: x => new { x.Module_ID, x.Course_ID },
                        principalTable: "Module",
                        principalColumns: new[] { "Module_ID", "Course_ID" },
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "learningActivity",
                columns: table => new
                {
                    Activity_ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Course_ID = table.Column<int>(type: "int", nullable: true),
                    Module_ID = table.Column<int>(type: "int", nullable: true),
                    activityType = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: true),
                    instruction_details = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true),
                    maxScore = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__learning__393F5BA5B56F0FBC", x => x.Activity_ID);
                    table.ForeignKey(
                        name: "FK__learningActivity__6A30C649",
                        columns: x => new { x.Module_ID, x.Course_ID },
                        principalTable: "Module",
                        principalColumns: new[] { "Module_ID", "Course_ID" },
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ModuleContent",
                columns: table => new
                {
                    Module_ID = table.Column<int>(type: "int", nullable: false),
                    Course_ID = table.Column<int>(type: "int", nullable: false),
                    contetntType = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__ModuleCo__2A345EC699571233", x => new { x.Module_ID, x.Course_ID, x.contetntType });
                    table.ForeignKey(
                        name: "FK__ModuleContent__5070F446",
                        columns: x => new { x.Module_ID, x.Course_ID },
                        principalTable: "Module",
                        principalColumns: new[] { "Module_ID", "Course_ID" },
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "TargetTraits",
                columns: table => new
                {
                    Module_ID = table.Column<int>(type: "int", nullable: false),
                    Course_ID = table.Column<int>(type: "int", nullable: false),
                    trait = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__TargetTr__8730B76F61B1C4E6", x => new { x.Module_ID, x.Course_ID, x.trait });
                    table.ForeignKey(
                        name: "FK__TargetTraits__4D94879B",
                        columns: x => new { x.Module_ID, x.Course_ID },
                        principalTable: "Module",
                        principalColumns: new[] { "Module_ID", "Course_ID" },
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "HealthCondition",
                columns: table => new
                {
                    Learner_ID = table.Column<int>(type: "int", nullable: false),
                    profileID = table.Column<int>(type: "int", nullable: false),
                    condition = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__HealthCo__1C0E75045BF6A8A7", x => new { x.Learner_ID, x.profileID, x.condition });
                    table.ForeignKey(
                        name: "FK__HealthCondition__4316F928",
                        columns: x => new { x.Learner_ID, x.profileID },
                        principalTable: "PersonalProfile",
                        principalColumns: new[] { "Learner_ID", "profileID" },
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "LearningPath",
                columns: table => new
                {
                    Path_ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Learner_ID = table.Column<int>(type: "int", nullable: true),
                    profileID = table.Column<int>(type: "int", nullable: true),
                    completion_status = table.Column<string>(type: "varchar(220)", unicode: false, maxLength: 220, nullable: true),
                    customContent = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true),
                    adaptiveRules = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Learning__12D3DFFB53D3853F", x => x.Path_ID);
                    table.ForeignKey(
                        name: "FK__LearningPath__6383C8BA",
                        columns: x => new { x.Learner_ID, x.profileID },
                        principalTable: "PersonalProfile",
                        principalColumns: new[] { "Learner_ID", "profileID" },
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "SkillProgression",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    proficiency_level = table.Column<int>(type: "int", nullable: false),
                    LearnerID = table.Column<int>(type: "int", nullable: true),
                    skill_name = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: true),
                    timestamp = table.Column<DateTime>(type: "datetime", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__SkillPro__3214EC271097B570", x => x.ID);
                    table.ForeignKey(
                        name: "FK__SkillProgression__339FAB6E",
                        columns: x => new { x.LearnerID, x.skill_name },
                        principalTable: "Skills",
                        principalColumns: new[] { "Learner_ID", "skill" },
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "LearnerCollaboration",
                columns: table => new
                {
                    LearnerId = table.Column<int>(type: "int", nullable: false),
                    QuestID = table.Column<int>(type: "int", nullable: false),
                    completion_status = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__LearnerC__CCCDE57649138492", x => new { x.LearnerId, x.QuestID });
                    table.ForeignKey(
                        name: "FK__LearnerCo__Learn__151B244E",
                        column: x => x.LearnerId,
                        principalTable: "Learner",
                        principalColumn: "Learner_ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK__LearnerCo__Quest__160F4887",
                        column: x => x.QuestID,
                        principalTable: "Collaborative",
                        principalColumn: "QuestID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "LearnerMastery",
                columns: table => new
                {
                    LearnerID = table.Column<int>(type: "int", nullable: false),
                    QuestID = table.Column<int>(type: "int", nullable: false),
                    completion_status = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__LearnerM__CCCDE5562A4D1BC5", x => new { x.LearnerID, x.QuestID });
                    table.ForeignKey(
                        name: "FK__LearnerMa__Learn__19DFD96B",
                        column: x => x.LearnerID,
                        principalTable: "Learner",
                        principalColumn: "Learner_ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK__LearnerMa__Quest__1AD3FDA4",
                        column: x => x.QuestID,
                        principalTable: "Skill_Mastery",
                        principalColumn: "QuestID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "FilledSurvey",
                columns: table => new
                {
                    SurveyID = table.Column<int>(type: "int", nullable: false),
                    Question = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    LearnerID = table.Column<int>(type: "int", nullable: false),
                    Answer = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__FilledSu__D89C33C70EECE04F", x => new { x.SurveyID, x.Question, x.LearnerID });
                    table.ForeignKey(
                        name: "FK__FilledSur__Learn__2CF2ADDF",
                        column: x => x.LearnerID,
                        principalTable: "Learner",
                        principalColumn: "Learner_ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK__FilledSurvey__2BFE89A6",
                        columns: x => new { x.SurveyID, x.Question },
                        principalTable: "SurveyQuestions",
                        principalColumns: new[] { "SurveyID", "Question" },
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "TakenAssessment",
                columns: table => new
                {
                    Assessment_ID = table.Column<int>(type: "int", nullable: false),
                    Learner_ID = table.Column<int>(type: "int", nullable: false),
                    ScoredPoint = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__TakenAss__88E23AED23474167", x => new { x.Assessment_ID, x.Learner_ID });
                    table.ForeignKey(
                        name: "FK__TakenAsse__Asses__5DCAEF64",
                        column: x => x.Assessment_ID,
                        principalTable: "Assessment",
                        principalColumn: "Assessment_ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK__TakenAsse__Learn__5EBF139D",
                        column: x => x.Learner_ID,
                        principalTable: "Learner",
                        principalColumn: "Learner_ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "LearnerDiscussion",
                columns: table => new
                {
                    ForumID = table.Column<int>(type: "int", nullable: false),
                    LearnerID = table.Column<int>(type: "int", nullable: false),
                    post = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: false),
                    time = table.Column<TimeOnly>(type: "time", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__LearnerD__942BB6D147C550D4", x => new { x.ForumID, x.LearnerID, x.post });
                    table.ForeignKey(
                        name: "FK__LearnerDi__Forum__282DF8C2",
                        column: x => x.ForumID,
                        principalTable: "Discussion_forum",
                        principalColumn: "forumID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK__LearnerDi__Learn__29221CFB",
                        column: x => x.LearnerID,
                        principalTable: "Learner",
                        principalColumn: "Learner_ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Emotional_feedback",
                columns: table => new
                {
                    FeedbackID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    LearnerID = table.Column<int>(type: "int", nullable: true),
                    Activity_ID = table.Column<int>(type: "int", nullable: true),
                    timestamp = table.Column<DateTime>(type: "datetime", nullable: true),
                    emotional_state = table.Column<string>(type: "varchar(20)", unicode: false, maxLength: 20, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Emotiona__6A4BEDF6E702E79A", x => x.FeedbackID);
                    table.ForeignKey(
                        name: "FK__Emotional__Activ__6EF57B66",
                        column: x => x.Activity_ID,
                        principalTable: "learningActivity",
                        principalColumn: "Activity_ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK__Emotional__emoti__6E01572D",
                        column: x => x.LearnerID,
                        principalTable: "Learner",
                        principalColumn: "Learner_ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Interaction_log",
                columns: table => new
                {
                    LogID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    activity_ID = table.Column<int>(type: "int", nullable: true),
                    LearnerID = table.Column<int>(type: "int", nullable: true),
                    Duration = table.Column<TimeOnly>(type: "time", nullable: true),
                    Timestamp = table.Column<DateTime>(type: "datetime", nullable: true),
                    action_type = table.Column<string>(type: "varchar(50)", unicode: false, maxLength: 50, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Interact__5E5499A8832998FA", x => x.LogID);
                    table.ForeignKey(
                        name: "FK__Interacti__Learn__03F0984C",
                        column: x => x.LearnerID,
                        principalTable: "Learner",
                        principalColumn: "Learner_ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK__Interacti__activ__02FC7413",
                        column: x => x.activity_ID,
                        principalTable: "learningActivity",
                        principalColumn: "Activity_ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "pathreview",
                columns: table => new
                {
                    Instructor_ID = table.Column<int>(type: "int", nullable: false),
                    Path_ID = table.Column<int>(type: "int", nullable: false),
                    feedback = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__pathrevi__7C66A775E13BC0EB", x => new { x.Instructor_ID, x.Path_ID });
                    table.ForeignKey(
                        name: "FK__pathrevie__Instr__66603565",
                        column: x => x.Instructor_ID,
                        principalTable: "Instructor",
                        principalColumn: "Instructor_ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK__pathrevie__Path___6754599E",
                        column: x => x.Path_ID,
                        principalTable: "LearningPath",
                        principalColumn: "Path_ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Emotionalfeedback_review",
                columns: table => new
                {
                    FeedbackID = table.Column<int>(type: "int", nullable: false),
                    InstructorID = table.Column<int>(type: "int", nullable: false),
                    review = table.Column<string>(type: "varchar(500)", unicode: false, maxLength: 500, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Emotiona__C39BFD4177CAF147", x => new { x.FeedbackID, x.InstructorID });
                    table.ForeignKey(
                        name: "FK__Emotional__Feedb__71D1E811",
                        column: x => x.FeedbackID,
                        principalTable: "Emotional_feedback",
                        principalColumn: "FeedbackID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK__Emotional__Instr__72C60C4A",
                        column: x => x.InstructorID,
                        principalTable: "Instructor",
                        principalColumn: "Instructor_ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Achievement_BadgeID",
                table: "Achievement",
                column: "BadgeID");

            migrationBuilder.CreateIndex(
                name: "IX_Achievement_LearnerID",
                table: "Achievement",
                column: "LearnerID");

            migrationBuilder.CreateIndex(
                name: "IX_Assessment_Module_ID_Course_ID",
                table: "Assessment",
                columns: new[] { "Module_ID", "Course_ID" });

            migrationBuilder.CreateIndex(
                name: "IX_ContentLibrary_Module_ID_Course_ID",
                table: "ContentLibrary",
                columns: new[] { "Module_ID", "Course_ID" });

            migrationBuilder.CreateIndex(
                name: "IX_Course_Enrollment_Course_ID",
                table: "Course_Enrollment",
                column: "Course_ID");

            migrationBuilder.CreateIndex(
                name: "IX_Course_Enrollment_Learner_ID",
                table: "Course_Enrollment",
                column: "Learner_ID");

            migrationBuilder.CreateIndex(
                name: "IX_Discussion_forum_Module_ID_Course_ID",
                table: "Discussion_forum",
                columns: new[] { "Module_ID", "Course_ID" });

            migrationBuilder.CreateIndex(
                name: "IX_Emotional_feedback_Activity_ID",
                table: "Emotional_feedback",
                column: "Activity_ID");

            migrationBuilder.CreateIndex(
                name: "IX_Emotional_feedback_LearnerID",
                table: "Emotional_feedback",
                column: "LearnerID");

            migrationBuilder.CreateIndex(
                name: "IX_Emotionalfeedback_review_InstructorID",
                table: "Emotionalfeedback_review",
                column: "InstructorID");

            migrationBuilder.CreateIndex(
                name: "IX_FilledSurvey_LearnerID",
                table: "FilledSurvey",
                column: "LearnerID");

            migrationBuilder.CreateIndex(
                name: "IX_Interaction_log_activity_ID",
                table: "Interaction_log",
                column: "activity_ID");

            migrationBuilder.CreateIndex(
                name: "IX_Interaction_log_LearnerID",
                table: "Interaction_log",
                column: "LearnerID");

            migrationBuilder.CreateIndex(
                name: "IX_LearnerCollaboration_QuestID",
                table: "LearnerCollaboration",
                column: "QuestID");

            migrationBuilder.CreateIndex(
                name: "IX_LearnerDiscussion_LearnerID",
                table: "LearnerDiscussion",
                column: "LearnerID");

            migrationBuilder.CreateIndex(
                name: "IX_LearnerMastery_QuestID",
                table: "LearnerMastery",
                column: "QuestID");

            migrationBuilder.CreateIndex(
                name: "IX_LearnersGoals_LearnerID",
                table: "LearnersGoals",
                column: "LearnerID");

            migrationBuilder.CreateIndex(
                name: "IX_learningActivity_Module_ID_Course_ID",
                table: "learningActivity",
                columns: new[] { "Module_ID", "Course_ID" });

            migrationBuilder.CreateIndex(
                name: "IX_LearningPath_Learner_ID_profileID",
                table: "LearningPath",
                columns: new[] { "Learner_ID", "profileID" });

            migrationBuilder.CreateIndex(
                name: "IX_Module_Course_ID",
                table: "Module",
                column: "Course_ID");

            migrationBuilder.CreateIndex(
                name: "IX_pathreview_Path_ID",
                table: "pathreview",
                column: "Path_ID");

            migrationBuilder.CreateIndex(
                name: "IX_QuestReward_LearnerID",
                table: "QuestReward",
                column: "LearnerID");

            migrationBuilder.CreateIndex(
                name: "IX_QuestReward_RewardID",
                table: "QuestReward",
                column: "RewardID");

            migrationBuilder.CreateIndex(
                name: "IX_Ranking_CourseID",
                table: "Ranking",
                column: "CourseID");

            migrationBuilder.CreateIndex(
                name: "IX_Ranking_LearnerID",
                table: "Ranking",
                column: "LearnerID");

            migrationBuilder.CreateIndex(
                name: "IX_RecivedNotfy_Notification_ID",
                table: "RecivedNotfy",
                column: "Notification_ID");

            migrationBuilder.CreateIndex(
                name: "UQ__Skill_Ma__B6619ACA08228CBC",
                table: "Skill_Mastery",
                column: "QuestID",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_SkillProgression_LearnerID_skill_name",
                table: "SkillProgression",
                columns: new[] { "LearnerID", "skill_name" });

            migrationBuilder.CreateIndex(
                name: "IX_TakenAssessment_Learner_ID",
                table: "TakenAssessment",
                column: "Learner_ID");

            migrationBuilder.CreateIndex(
                name: "IX_Teaches_Course_ID",
                table: "Teaches",
                column: "Course_ID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Achievement");

            migrationBuilder.DropTable(
                name: "ContentLibrary");

            migrationBuilder.DropTable(
                name: "Course_Enrollment");

            migrationBuilder.DropTable(
                name: "CoursePrerequisites");

            migrationBuilder.DropTable(
                name: "Emotionalfeedback_review");

            migrationBuilder.DropTable(
                name: "FilledSurvey");

            migrationBuilder.DropTable(
                name: "HealthCondition");

            migrationBuilder.DropTable(
                name: "Interaction_log");

            migrationBuilder.DropTable(
                name: "LearnerCollaboration");

            migrationBuilder.DropTable(
                name: "LearnerDiscussion");

            migrationBuilder.DropTable(
                name: "LearnerMastery");

            migrationBuilder.DropTable(
                name: "LearnersGoals");

            migrationBuilder.DropTable(
                name: "LearningPrefrences");

            migrationBuilder.DropTable(
                name: "ModuleContent");

            migrationBuilder.DropTable(
                name: "pathreview");

            migrationBuilder.DropTable(
                name: "QuestReward");

            migrationBuilder.DropTable(
                name: "Ranking");

            migrationBuilder.DropTable(
                name: "RecivedNotfy");

            migrationBuilder.DropTable(
                name: "SkillProgression");

            migrationBuilder.DropTable(
                name: "TakenAssessment");

            migrationBuilder.DropTable(
                name: "TargetTraits");

            migrationBuilder.DropTable(
                name: "Teaches");

            migrationBuilder.DropTable(
                name: "Badge");

            migrationBuilder.DropTable(
                name: "Emotional_feedback");

            migrationBuilder.DropTable(
                name: "SurveyQuestions");

            migrationBuilder.DropTable(
                name: "Collaborative");

            migrationBuilder.DropTable(
                name: "Discussion_forum");

            migrationBuilder.DropTable(
                name: "Skill_Mastery");

            migrationBuilder.DropTable(
                name: "Learning_goal");

            migrationBuilder.DropTable(
                name: "LearningPath");

            migrationBuilder.DropTable(
                name: "Reward");

            migrationBuilder.DropTable(
                name: "Leaderboard");

            migrationBuilder.DropTable(
                name: "Notification");

            migrationBuilder.DropTable(
                name: "Skills");

            migrationBuilder.DropTable(
                name: "Assessment");

            migrationBuilder.DropTable(
                name: "Instructor");

            migrationBuilder.DropTable(
                name: "learningActivity");

            migrationBuilder.DropTable(
                name: "Survey");

            migrationBuilder.DropTable(
                name: "Quest");

            migrationBuilder.DropTable(
                name: "PersonalProfile");

            migrationBuilder.DropTable(
                name: "Module");

            migrationBuilder.DropTable(
                name: "Learner");

            migrationBuilder.DropTable(
                name: "Course");
        }
    }
}
