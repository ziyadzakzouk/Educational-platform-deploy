using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[Table("Quest")]
public partial class Quest
{
    [Key]
    [Column("QuestID")]
    public int QuestId { get; set; }

    [Column("difficulty_level")]
    public int? DifficultyLevel { get; set; }

    [Column("criteria")]
    [StringLength(50)]
    [Unicode(false)]
    public string? Criteria { get; set; }

    [Column("description")]
    [StringLength(200)]
    [Unicode(false)]
    public string? Description { get; set; }

    [Column("title")]
    [StringLength(60)]
    [Unicode(false)]
    public string? Title { get; set; }

    [InverseProperty("Quest")]
    public virtual Collaborative? Collaborative { get; set; }

    [InverseProperty("Quest")]
    public virtual ICollection<QuestReward> QuestRewards { get; set; } = new List<QuestReward>();

    [InverseProperty("Quest")]
    public virtual SkillMastery? SkillMastery { get; set; }
}
