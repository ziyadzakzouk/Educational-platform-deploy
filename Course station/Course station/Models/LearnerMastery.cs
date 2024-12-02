using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[PrimaryKey("LearnerId", "QuestId")]
[Table("LearnerMastery")]
public partial class LearnerMastery
{
    [Key]
    [Column("LearnerID")]
    public int LearnerId { get; set; }

    [Key]
    [Column("QuestID")]
    public int QuestId { get; set; }

    [Column("completion_status")]
    [StringLength(50)]
    [Unicode(false)]
    public string? CompletionStatus { get; set; }

    [ForeignKey("LearnerId")]
    [InverseProperty("LearnerMasteries")]
    public virtual Learner Learner { get; set; } = null!;

    [ForeignKey("QuestId")]
    [InverseProperty("LearnerMasteries")]
    public virtual SkillMastery Quest { get; set; } = null!;
}
