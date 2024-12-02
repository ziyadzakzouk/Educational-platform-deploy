using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[Table("Reward")]
public partial class Reward
{
    [Key]
    [Column("RewardID")]
    public int RewardId { get; set; }

    [Column("value")]
    public int? Value { get; set; }

    [Column("description")]
    [StringLength(200)]
    [Unicode(false)]
    public string? Description { get; set; }

    [Column("type")]
    [StringLength(50)]
    [Unicode(false)]
    public string? Type { get; set; }

    [InverseProperty("Reward")]
    public virtual ICollection<QuestReward> QuestRewards { get; set; } = new List<QuestReward>();
}
