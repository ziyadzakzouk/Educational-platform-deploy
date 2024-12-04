using System.ComponentModel.DataAnnotations;

namespace Course_station.Models
{
    public class LoginViewModel
    {
        [Required]
        public int Learner_ID { get; set; }

        [Required]
        public string Password { get; set; }
    }
    }
