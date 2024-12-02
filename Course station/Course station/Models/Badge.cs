using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[Table("Badge")]
public partial class Badge
{
    [Key]
    [Column("BadgeID")]
    public int BadgeId { get; set; }

    [Column("title")]
    [StringLength(50)]
    [Unicode(false)]
    public string? Title { get; set; }

    [Column("description")]
    [StringLength(200)]
    [Unicode(false)]
    public string? Description { get; set; }

    [Column("criteria")]
    [StringLength(50)]
    [Unicode(false)]
    public string? Criteria { get; set; }

    [Column("points")]
    public int? Points { get; set; }

    [InverseProperty("Badge")]
    public virtual ICollection<Achievement> Achievements { get; set; } = new List<Achievement>();
}
