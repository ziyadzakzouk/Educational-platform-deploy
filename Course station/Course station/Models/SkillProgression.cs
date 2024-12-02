using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[Table("SkillProgression")]
public partial class SkillProgression
{
    [Key]
    [Column("ID")]
    public int Id { get; set; }

    [Column("proficiency_level")]
    public int ProficiencyLevel { get; set; }

    [Column("LearnerID")]
    public int? LearnerId { get; set; }

    [Column("skill_name")]
    [StringLength(50)]
    [Unicode(false)]
    public string? SkillName { get; set; }

    [Column("timestamp", TypeName = "datetime")]
    public DateTime Timestamp { get; set; }

    [ForeignKey("LearnerId, SkillName")]
    [InverseProperty("SkillProgressions")]
    public virtual Skill? Skill { get; set; }
}
