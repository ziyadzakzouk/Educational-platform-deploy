using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[PrimaryKey("QuestId", "Skill")]
[Table("Skill_Mastery")]
[Index("QuestId", Name = "UQ__Skill_Ma__B6619ACA08228CBC", IsUnique = true)]
public partial class SkillMastery
{
    [Key]
    [Column("QuestID")]
    public int QuestId { get; set; }

    [Key]
    [StringLength(255)]
    [Unicode(false)]
    public string Skill { get; set; } = null!;

    [InverseProperty("Quest")]
    public virtual ICollection<LearnerMastery> LearnerMasteries { get; set; } = new List<LearnerMastery>();

    [ForeignKey("QuestId")]
    [InverseProperty("SkillMastery")]
    public virtual Quest Quest { get; set; } = null!;
}
