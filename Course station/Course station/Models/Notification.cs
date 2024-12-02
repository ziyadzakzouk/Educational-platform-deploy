using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[Table("Notification")]
public partial class Notification
{
    [Key]
    [Column("Notification_ID")]
    public int NotificationId { get; set; }

    [Column("time_stamp", TypeName = "datetime")]
    public DateTime? TimeStamp { get; set; }

    [Column("message")]
    [StringLength(255)]
    [Unicode(false)]
    public string? Message { get; set; }

    [Column("urgency")]
    [StringLength(50)]
    [Unicode(false)]
    public string? Urgency { get; set; }

    [Column("readstatus")]
    public bool? Readstatus { get; set; }

    [ForeignKey("NotificationId")]
    [InverseProperty("Notifications")]
    public virtual ICollection<Learner> Learners { get; set; } = new List<Learner>();
}
