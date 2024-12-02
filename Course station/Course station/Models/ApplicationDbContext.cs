using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

public partial class ApplicationDbContext : DbContext
{
    public ApplicationDbContext()
    {
    }

    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Achievement> Achievements { get; set; }

    public virtual DbSet<Assessment> Assessments { get; set; }

    public virtual DbSet<Badge> Badges { get; set; }

    public virtual DbSet<Collaborative> Collaboratives { get; set; }

    public virtual DbSet<ContentLibrary> ContentLibraries { get; set; }

    public virtual DbSet<Course> Courses { get; set; }

    public virtual DbSet<CourseEnrollment> CourseEnrollments { get; set; }

    public virtual DbSet<CoursePrerequisite> CoursePrerequisites { get; set; }

    public virtual DbSet<DiscussionForum> DiscussionForums { get; set; }

    public virtual DbSet<EmotionalFeedback> EmotionalFeedbacks { get; set; }

    public virtual DbSet<EmotionalfeedbackReview> EmotionalfeedbackReviews { get; set; }

    public virtual DbSet<FilledSurvey> FilledSurveys { get; set; }

    public virtual DbSet<HealthCondition> HealthConditions { get; set; }

    public virtual DbSet<Instructor> Instructors { get; set; }

    public virtual DbSet<InstructorCount> InstructorCounts { get; set; }

    public virtual DbSet<InteractionLog> InteractionLogs { get; set; }

    public virtual DbSet<Leaderboard> Leaderboards { get; set; }

    public virtual DbSet<Learner> Learners { get; set; }

    public virtual DbSet<LearnerCollaboration> LearnerCollaborations { get; set; }

    public virtual DbSet<LearnerDiscussion> LearnerDiscussions { get; set; }

    public virtual DbSet<LearnerMastery> LearnerMasteries { get; set; }

    public virtual DbSet<LearningActivity> LearningActivities { get; set; }

    public virtual DbSet<LearningGoal> LearningGoals { get; set; }

    public virtual DbSet<LearningPath> LearningPaths { get; set; }

    public virtual DbSet<LearningPrefrence> LearningPrefrences { get; set; }

    public virtual DbSet<Module> Modules { get; set; }

    public virtual DbSet<ModuleContent> ModuleContents { get; set; }

    public virtual DbSet<Notification> Notifications { get; set; }

    public virtual DbSet<Pathreview> Pathreviews { get; set; }

    public virtual DbSet<PersonalProfile> PersonalProfiles { get; set; }

    public virtual DbSet<Quest> Quests { get; set; }

    public virtual DbSet<QuestReward> QuestRewards { get; set; }

    public virtual DbSet<Ranking> Rankings { get; set; }

    public virtual DbSet<Reward> Rewards { get; set; }

    public virtual DbSet<Skill> Skills { get; set; }

    public virtual DbSet<SkillMastery> SkillMasteries { get; set; }

    public virtual DbSet<SkillProgression> SkillProgressions { get; set; }

    public virtual DbSet<Survey> Surveys { get; set; }

    public virtual DbSet<SurveyQuestion> SurveyQuestions { get; set; }

    public virtual DbSet<TakenAssessment> TakenAssessments { get; set; }

    public virtual DbSet<TargetTrait> TargetTraits { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Server=YOUSSEF2099XX\\JOE_PC;Database=EduBase;Trusted_Connection=True;TrustServerCertificate=True;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Achievement>(entity =>
        {
            entity.HasKey(e => e.AchievementId).HasName("PK__Achievem__276330E068F35568");

            entity.HasOne(d => d.Badge).WithMany(p => p.Achievements)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Achieveme__Badge__30C33EC3");

            entity.HasOne(d => d.Learner).WithMany(p => p.Achievements)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Achieveme__Learn__2FCF1A8A");
        });

        modelBuilder.Entity<Assessment>(entity =>
        {
            entity.HasKey(e => e.AssessmentId).HasName("PK__Assessme__6B3C1D927D3DADAF");

            entity.HasOne(d => d.Module).WithMany(p => p.Assessments)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Assessment__5AEE82B9");
        });

        modelBuilder.Entity<Badge>(entity =>
        {
            entity.HasKey(e => e.BadgeId).HasName("PK__Badge__1918237C4A82E7F9");
        });

        modelBuilder.Entity<Collaborative>(entity =>
        {
            entity.HasKey(e => e.QuestId).HasName("PK__Collabor__B6619ACBCA827253");

            entity.Property(e => e.QuestId).ValueGeneratedNever();

            entity.HasOne(d => d.Quest).WithOne(p => p.Collaborative).HasConstraintName("FK__Collabora__Quest__123EB7A3");
        });

        modelBuilder.Entity<ContentLibrary>(entity =>
        {
            entity.HasKey(e => e.LibId).HasName("PK__ContentL__4151D01392B24AE4");

            entity.HasOne(d => d.Module).WithMany(p => p.ContentLibraries)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__ContentLibrary__534D60F1");
        });

        modelBuilder.Entity<Course>(entity =>
        {
            entity.HasKey(e => e.CourseId).HasName("PK__Course__37E005FB479EE564");
        });

        modelBuilder.Entity<CourseEnrollment>(entity =>
        {
            entity.HasKey(e => e.EnrollmentId).HasName("PK__Course_E__4365BD6AD0C13685");

            entity.HasOne(d => d.Course).WithMany(p => p.CourseEnrollments)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Course_En__Cours__571DF1D5");

            entity.HasOne(d => d.Learner).WithMany(p => p.CourseEnrollments)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Course_En__Learn__5629CD9C");
        });

        modelBuilder.Entity<CoursePrerequisite>(entity =>
        {
            entity.HasKey(e => new { e.CourseId, e.Prerequisite }).HasName("PK__CoursePr__A33A4ED1E66E9C8B");

            entity.HasOne(d => d.Course).WithMany(p => p.CoursePrerequisites).HasConstraintName("FK__CoursePre__Cours__47DBAE45");
        });

        modelBuilder.Entity<DiscussionForum>(entity =>
        {
            entity.HasKey(e => e.ForumId).HasName("PK__Discussi__BBA7A440B88B57A0");

            entity.HasOne(d => d.Module).WithMany(p => p.DiscussionForums)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Discussion_forum__208CD6FA");
        });

        modelBuilder.Entity<EmotionalFeedback>(entity =>
        {
            entity.HasKey(e => e.FeedbackId).HasName("PK__Emotiona__6A4BEDF6E702E79A");

            entity.HasOne(d => d.Activity).WithMany(p => p.EmotionalFeedbacks)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Emotional__Activ__6EF57B66");

            entity.HasOne(d => d.Learner).WithMany(p => p.EmotionalFeedbacks)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Emotional__emoti__6E01572D");
        });

        modelBuilder.Entity<EmotionalfeedbackReview>(entity =>
        {
            entity.HasKey(e => new { e.FeedbackId, e.InstructorId }).HasName("PK__Emotiona__C39BFD4177CAF147");

            entity.HasOne(d => d.Feedback).WithMany(p => p.EmotionalfeedbackReviews).HasConstraintName("FK__Emotional__Feedb__71D1E811");

            entity.HasOne(d => d.Instructor).WithMany(p => p.EmotionalfeedbackReviews).HasConstraintName("FK__Emotional__Instr__72C60C4A");
        });

        modelBuilder.Entity<FilledSurvey>(entity =>
        {
            entity.HasKey(e => new { e.SurveyId, e.Question, e.LearnerId }).HasName("PK__FilledSu__D89C33C70EECE04F");

            entity.HasOne(d => d.Learner).WithMany(p => p.FilledSurveys).HasConstraintName("FK__FilledSur__Learn__2CF2ADDF");

            entity.HasOne(d => d.SurveyQuestion).WithMany(p => p.FilledSurveys).HasConstraintName("FK__FilledSurvey__2BFE89A6");
        });

        modelBuilder.Entity<HealthCondition>(entity =>
        {
            entity.HasKey(e => new { e.LearnerId, e.ProfileId, e.Condition }).HasName("PK__HealthCo__1C0E75045BF6A8A7");

            entity.HasOne(d => d.PersonalProfile).WithMany(p => p.HealthConditions).HasConstraintName("FK__HealthCondition__4316F928");
        });

        modelBuilder.Entity<Instructor>(entity =>
        {
            entity.HasKey(e => e.InstructorId).HasName("PK__Instruct__DD4B9A8ADBF15F10");

            entity.HasMany(d => d.Courses).WithMany(p => p.Instructors)
                .UsingEntity<Dictionary<string, object>>(
                    "Teach",
                    r => r.HasOne<Course>().WithMany()
                        .HasForeignKey("CourseId")
                        .HasConstraintName("FK__Teaches__Course___76969D2E"),
                    l => l.HasOne<Instructor>().WithMany()
                        .HasForeignKey("InstructorId")
                        .HasConstraintName("FK__Teaches__Instruc__75A278F5"),
                    j =>
                    {
                        j.HasKey("InstructorId", "CourseId").HasName("PK__Teaches__7E359AD5C2111E9F");
                        j.ToTable("Teaches");
                        j.IndexerProperty<int>("InstructorId").HasColumnName("Instructor_ID");
                        j.IndexerProperty<int>("CourseId").HasColumnName("Course_ID");
                    });
        });

        modelBuilder.Entity<InstructorCount>(entity =>
        {
            entity.ToView("InstructorCount");
        });

        modelBuilder.Entity<InteractionLog>(entity =>
        {
            entity.HasKey(e => e.LogId).HasName("PK__Interact__5E5499A8832998FA");

            entity.HasOne(d => d.Activity).WithMany(p => p.InteractionLogs)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Interacti__activ__02FC7413");

            entity.HasOne(d => d.Learner).WithMany(p => p.InteractionLogs)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Interacti__Learn__03F0984C");
        });

        modelBuilder.Entity<Leaderboard>(entity =>
        {
            entity.HasKey(e => e.BoardId).HasName("PK__Leaderbo__F9646BD254AD5C0D");
        });

        modelBuilder.Entity<Learner>(entity =>
        {
            entity.HasKey(e => e.LearnerId).HasName("PK__Learner__3DE277FF157AE6B6");

            entity.HasMany(d => d.Notifications).WithMany(p => p.Learners)
                .UsingEntity<Dictionary<string, object>>(
                    "RecivedNotfy",
                    r => r.HasOne<Notification>().WithMany()
                        .HasForeignKey("NotificationId")
                        .HasConstraintName("FK__RecivedNo__Notif__7E37BEF6"),
                    l => l.HasOne<Learner>().WithMany()
                        .HasForeignKey("LearnerId")
                        .HasConstraintName("FK__RecivedNo__Learn__7D439ABD"),
                    j =>
                    {
                        j.HasKey("LearnerId", "NotificationId").HasName("PK__RecivedN__752361F4E8319A6D");
                        j.ToTable("RecivedNotfy");
                        j.IndexerProperty<int>("LearnerId").HasColumnName("Learner_ID");
                        j.IndexerProperty<int>("NotificationId").HasColumnName("Notification_ID");
                    });
        });

        modelBuilder.Entity<LearnerCollaboration>(entity =>
        {
            entity.HasKey(e => new { e.LearnerId, e.QuestId }).HasName("PK__LearnerC__CCCDE57649138492");

            entity.HasOne(d => d.Learner).WithMany(p => p.LearnerCollaborations).HasConstraintName("FK__LearnerCo__Learn__151B244E");

            entity.HasOne(d => d.Quest).WithMany(p => p.LearnerCollaborations).HasConstraintName("FK__LearnerCo__Quest__160F4887");
        });

        modelBuilder.Entity<LearnerDiscussion>(entity =>
        {
            entity.HasKey(e => new { e.ForumId, e.LearnerId, e.Post }).HasName("PK__LearnerD__942BB6D147C550D4");

            entity.HasOne(d => d.Forum).WithMany(p => p.LearnerDiscussions).HasConstraintName("FK__LearnerDi__Forum__282DF8C2");

            entity.HasOne(d => d.Learner).WithMany(p => p.LearnerDiscussions).HasConstraintName("FK__LearnerDi__Learn__29221CFB");
        });

        modelBuilder.Entity<LearnerMastery>(entity =>
        {
            entity.HasKey(e => new { e.LearnerId, e.QuestId }).HasName("PK__LearnerM__CCCDE5562A4D1BC5");

            entity.HasOne(d => d.Learner).WithMany(p => p.LearnerMasteries).HasConstraintName("FK__LearnerMa__Learn__19DFD96B");

            entity.HasOne(d => d.Quest).WithMany(p => p.LearnerMasteries)
                .HasPrincipalKey(p => p.QuestId)
                .HasForeignKey(d => d.QuestId)
                .HasConstraintName("FK__LearnerMa__Quest__1AD3FDA4");
        });

        modelBuilder.Entity<LearningActivity>(entity =>
        {
            entity.HasKey(e => e.ActivityId).HasName("PK__learning__393F5BA5B56F0FBC");

            entity.HasOne(d => d.Module).WithMany(p => p.LearningActivities)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__learningActivity__6A30C649");
        });

        modelBuilder.Entity<LearningGoal>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Learning__3214EC2756A1DAB0");

            entity.HasMany(d => d.Learners).WithMany(p => p.Goals)
                .UsingEntity<Dictionary<string, object>>(
                    "LearnersGoal",
                    r => r.HasOne<Learner>().WithMany()
                        .HasForeignKey("LearnerId")
                        .HasConstraintName("FK__LearnersG__Learn__40058253"),
                    l => l.HasOne<LearningGoal>().WithMany()
                        .HasForeignKey("GoalId")
                        .HasConstraintName("FK__LearnersG__GoalI__3F115E1A"),
                    j =>
                    {
                        j.HasKey("GoalId", "LearnerId").HasName("PK__Learners__3C3540FE247F3690");
                        j.ToTable("LearnersGoals");
                        j.IndexerProperty<int>("GoalId").HasColumnName("GoalID");
                        j.IndexerProperty<int>("LearnerId").HasColumnName("LearnerID");
                    });
        });

        modelBuilder.Entity<LearningPath>(entity =>
        {
            entity.HasKey(e => e.PathId).HasName("PK__Learning__12D3DFFB53D3853F");

            entity.HasOne(d => d.PersonalProfile).WithMany(p => p.LearningPaths)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__LearningPath__6383C8BA");
        });

        modelBuilder.Entity<LearningPrefrence>(entity =>
        {
            entity.HasKey(e => new { e.LearnerId, e.Prefrences }).HasName("PK__Learning__7B1D3263133AC949");

            entity.HasOne(d => d.Learner).WithMany(p => p.LearningPrefrences).HasConstraintName("FK__LearningP__Learn__3D5E1FD2");
        });

        modelBuilder.Entity<Module>(entity =>
        {
            entity.HasKey(e => new { e.ModuleId, e.CourseId }).HasName("PK__Module__BE9AE0776D951244");

            entity.Property(e => e.ModuleId).ValueGeneratedOnAdd();

            entity.HasOne(d => d.Course).WithMany(p => p.Modules).HasConstraintName("FK__Module__Course_I__4AB81AF0");
        });

        modelBuilder.Entity<ModuleContent>(entity =>
        {
            entity.HasKey(e => new { e.ModuleId, e.CourseId, e.ContetntType }).HasName("PK__ModuleCo__2A345EC699571233");

            entity.HasOne(d => d.Module).WithMany(p => p.ModuleContents).HasConstraintName("FK__ModuleContent__5070F446");
        });

        modelBuilder.Entity<Notification>(entity =>
        {
            entity.HasKey(e => e.NotificationId).HasName("PK__Notifica__8C1160B58591F297");

            entity.Property(e => e.TimeStamp).HasDefaultValueSql("(getdate())");
        });

        modelBuilder.Entity<Pathreview>(entity =>
        {
            entity.HasKey(e => new { e.InstructorId, e.PathId }).HasName("PK__pathrevi__7C66A775E13BC0EB");

            entity.HasOne(d => d.Instructor).WithMany(p => p.Pathreviews).HasConstraintName("FK__pathrevie__Instr__66603565");

            entity.HasOne(d => d.Path).WithMany(p => p.Pathreviews).HasConstraintName("FK__pathrevie__Path___6754599E");
        });

        modelBuilder.Entity<PersonalProfile>(entity =>
        {
            entity.HasKey(e => new { e.LearnerId, e.ProfileId }).HasName("PK__Personal__BA3661C6CC87238E");

            entity.HasOne(d => d.Learner).WithMany(p => p.PersonalProfiles).HasConstraintName("FK__PersonalP__Learn__403A8C7D");
        });

        modelBuilder.Entity<Quest>(entity =>
        {
            entity.HasKey(e => e.QuestId).HasName("PK__Quest__B6619ACB864E1E60");
        });

        modelBuilder.Entity<QuestReward>(entity =>
        {
            entity.HasKey(e => new { e.QuestId, e.RewardId, e.LearnerId }).HasName("PK__QuestRew__C523306E95866F17");

            entity.Property(e => e.TimeEarned).HasDefaultValueSql("(getdate())");

            entity.HasOne(d => d.Learner).WithMany(p => p.QuestRewards).HasConstraintName("FK__QuestRewa__Learn__0B91BA14");

            entity.HasOne(d => d.Quest).WithMany(p => p.QuestRewards).HasConstraintName("FK__QuestRewa__Quest__09A971A2");

            entity.HasOne(d => d.Reward).WithMany(p => p.QuestRewards).HasConstraintName("FK__QuestRewa__Rewar__0A9D95DB");
        });

        modelBuilder.Entity<Ranking>(entity =>
        {
            entity.HasKey(e => new { e.BoardId, e.LearnerId }).HasName("PK__Ranking__4F1ED41D4273594D");

            entity.HasOne(d => d.Board).WithMany(p => p.Rankings).HasConstraintName("FK__Ranking__BoardID__3864608B");

            entity.HasOne(d => d.Course).WithMany(p => p.Rankings)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__Ranking__CourseI__3A4CA8FD");

            entity.HasOne(d => d.Learner).WithMany(p => p.Rankings).HasConstraintName("FK__Ranking__Learner__395884C4");
        });

        modelBuilder.Entity<Reward>(entity =>
        {
            entity.HasKey(e => e.RewardId).HasName("PK__Reward__82501599B39290AF");
        });

        modelBuilder.Entity<Skill>(entity =>
        {
            entity.HasKey(e => new { e.LearnerId, e.Skill1 }).HasName("PK__Skills__9E1255A04DD855D7");

            entity.HasOne(d => d.Learner).WithMany(p => p.Skills).HasConstraintName("FK__Skills__Learner___3A81B327");
        });

        modelBuilder.Entity<SkillMastery>(entity =>
        {
            entity.HasKey(e => new { e.QuestId, e.Skill }).HasName("PK__Skill_Ma__CF6E15970A8FE247");

            entity.HasOne(d => d.Quest).WithOne(p => p.SkillMastery).HasConstraintName("FK__Skill_Mas__Quest__0F624AF8");
        });

        modelBuilder.Entity<SkillProgression>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__SkillPro__3214EC271097B570");

            entity.HasOne(d => d.Skill).WithMany(p => p.SkillProgressions)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK__SkillProgression__339FAB6E");
        });

        modelBuilder.Entity<Survey>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Survey__3214EC277BEB44F7");
        });

        modelBuilder.Entity<SurveyQuestion>(entity =>
        {
            entity.HasKey(e => new { e.SurveyId, e.Question }).HasName("PK__SurveyQu__23FB983BDB0F3FCB");

            entity.HasOne(d => d.Survey).WithMany(p => p.SurveyQuestions).HasConstraintName("FK__SurveyQue__Surve__25518C17");
        });

        modelBuilder.Entity<TakenAssessment>(entity =>
        {
            entity.HasKey(e => new { e.AssessmentId, e.LearnerId }).HasName("PK__TakenAss__88E23AED23474167");

            entity.HasOne(d => d.Assessment).WithMany(p => p.TakenAssessments).HasConstraintName("FK__TakenAsse__Asses__5DCAEF64");

            entity.HasOne(d => d.Learner).WithMany(p => p.TakenAssessments).HasConstraintName("FK__TakenAsse__Learn__5EBF139D");
        });

        modelBuilder.Entity<TargetTrait>(entity =>
        {
            entity.HasKey(e => new { e.ModuleId, e.CourseId, e.Trait }).HasName("PK__TargetTr__8730B76F61B1C4E6");

            entity.HasOne(d => d.Module).WithMany(p => p.TargetTraits).HasConstraintName("FK__TargetTraits__4D94879B");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
