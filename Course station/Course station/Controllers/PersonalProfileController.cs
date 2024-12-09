using Microsoft.AspNetCore.Mvc;
using Course_station.Models;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Course_station.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PersonalProfileController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public PersonalProfileController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: api/PersonalProfile
        [HttpGet]
        public async Task<ActionResult<IEnumerable<PersonalProfile>>> GetPersonalProfiles()
        {
            return await _context.PersonalProfiles.ToListAsync();
        }

        // GET: api/PersonalProfile/5
        [HttpGet("{id}")]
        public async Task<ActionResult<PersonalProfile>> GetPersonalProfile(int id)
        {
            var personalProfile = await _context.PersonalProfiles.FindAsync(id);

            if (personalProfile == null)
            {
                return NotFound();
            }

            return personalProfile;
        }

        // PUT: api/PersonalProfile/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPersonalProfile(int id, PersonalProfile personalProfile)
        {
            if (id != personalProfile.ProfileId)
            {
                return BadRequest();
            }

            _context.Entry(personalProfile).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PersonalProfileExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/PersonalProfile
        [HttpPost]
        public async Task<ActionResult<PersonalProfile>> PostPersonalProfile(PersonalProfile personalProfile)
        {
            _context.PersonalProfiles.Add(personalProfile);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPersonalProfile", new { id = personalProfile.ProfileId }, personalProfile);
        }

        // DELETE: api/PersonalProfile/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePersonalProfile(int id)
        {
            var personalProfile = await _context.PersonalProfiles.FindAsync(id);
            if (personalProfile == null)
            {
                return NotFound();
            }

            _context.PersonalProfiles.Remove(personalProfile);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool PersonalProfileExists(int id)
        {
            return _context.PersonalProfiles.Any(e => e.ProfileId == id);
        }
    }
}
