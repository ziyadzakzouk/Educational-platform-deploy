using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[Table("Learner")]
public partial class Learner
{
    [Key]
    [Column("Learner_ID")]
    public int LearnerId { get; set; }

    [Column("first_name")]
    [StringLength(20)]
    [Unicode(false)]
    public string? FirstName { get; set; }

    [Column("last_name")]
    [StringLength(20)]
    [Unicode(false)]
    public string? LastName { get; set; }

    [Column("birthday")]
    public DateOnly? Birthday { get; set; }

    [Column("gender")]
    [StringLength(10)]
    [Unicode(false)]
    public string? Gender { get; set; }

    [Column("country")]
    [StringLength(20)]
    [Unicode(false)]
    public string? Country { get; set; }

    [Column("cultural_background")]
    [StringLength(50)]
    [Unicode(false)]
    public string? CulturalBackground { get; set; }

    [InverseProperty("Learner")]
    public virtual ICollection<Achievement> Achievements { get; set; } = new List<Achievement>();

    [InverseProperty("Learner")]
    public virtual ICollection<CourseEnrollment> CourseEnrollments { get; set; } = new List<CourseEnrollment>();

    [InverseProperty("Learner")]
    public virtual ICollection<EmotionalFeedback> EmotionalFeedbacks { get; set; } = new List<EmotionalFeedback>();

    [InverseProperty("Learner")]
    public virtual ICollection<FilledSurvey> FilledSurveys { get; set; } = new List<FilledSurvey>();

    [InverseProperty("Learner")]
    public virtual ICollection<InteractionLog> InteractionLogs { get; set; } = new List<InteractionLog>();

    [InverseProperty("Learner")]
    public virtual ICollection<LearnerCollaboration> LearnerCollaborations { get; set; } = new List<LearnerCollaboration>();

    [InverseProperty("Learner")]
    public virtual ICollection<LearnerDiscussion> LearnerDiscussions { get; set; } = new List<LearnerDiscussion>();

    [InverseProperty("Learner")]
    public virtual ICollection<LearnerMastery> LearnerMasteries { get; set; } = new List<LearnerMastery>();

    [InverseProperty("Learner")]
    public virtual ICollection<LearningPrefrence> LearningPrefrences { get; set; } = new List<LearningPrefrence>();

    [InverseProperty("Learner")]
    public virtual ICollection<PersonalProfile> PersonalProfiles { get; set; } = new List<PersonalProfile>();

    [InverseProperty("Learner")]
    public virtual ICollection<QuestReward> QuestRewards { get; set; } = new List<QuestReward>();

    [InverseProperty("Learner")]
    public virtual ICollection<Ranking> Rankings { get; set; } = new List<Ranking>();

    [InverseProperty("Learner")]
    public virtual ICollection<Skill> Skills { get; set; } = new List<Skill>();

    [InverseProperty("Learner")]
    public virtual ICollection<TakenAssessment> TakenAssessments { get; set; } = new List<TakenAssessment>();

    [ForeignKey("LearnerId")]
    [InverseProperty("Learners")]
    public virtual ICollection<LearningGoal> Goals { get; set; } = new List<LearningGoal>();

    [ForeignKey("LearnerId")]
    [InverseProperty("Learners")]
    public virtual ICollection<Notification> Notifications { get; set; } = new List<Notification>();
}
