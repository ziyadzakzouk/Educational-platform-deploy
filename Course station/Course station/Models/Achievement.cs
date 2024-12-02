using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[Table("Achievement")]
public partial class Achievement
{
    [Key]
    [Column("AchievementID")]
    public int AchievementId { get; set; }

    [Column("LearnerID")]
    public int? LearnerId { get; set; }

    [Column("BadgeID")]
    public int? BadgeId { get; set; }

    [Column(TypeName = "text")]
    public string? Description { get; set; }

    public DateOnly DateEarned { get; set; }

    [StringLength(50)]
    [Unicode(false)]
    public string Type { get; set; } = null!;

    [ForeignKey("BadgeId")]
    [InverseProperty("Achievements")]
    public virtual Badge? Badge { get; set; }

    [ForeignKey("LearnerId")]
    [InverseProperty("Achievements")]
    public virtual Learner? Learner { get; set; }
}
