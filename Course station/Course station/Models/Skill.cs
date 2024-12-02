using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[PrimaryKey("LearnerId", "Skill1")]
public partial class Skill
{
    [Key]
    [Column("Learner_ID")]
    public int LearnerId { get; set; }

    [Key]
    [Column("skill")]
    [StringLength(50)]
    [Unicode(false)]
    public string Skill1 { get; set; } = null!;

    [ForeignKey("LearnerId")]
    [InverseProperty("Skills")]
    public virtual Learner Learner { get; set; } = null!;

    [InverseProperty("Skill")]
    public virtual ICollection<SkillProgression> SkillProgressions { get; set; } = new List<SkillProgression>();
}
