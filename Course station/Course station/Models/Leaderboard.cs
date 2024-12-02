using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[Table("Leaderboard")]
public partial class Leaderboard
{
    [Key]
    [Column("BoardID")]
    public int BoardId { get; set; }

    [Column("season")]
    [StringLength(20)]
    [Unicode(false)]
    public string Season { get; set; } = null!;

    [InverseProperty("Board")]
    public virtual ICollection<Ranking> Rankings { get; set; } = new List<Ranking>();
}
