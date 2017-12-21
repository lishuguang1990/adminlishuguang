using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.ModelView
{
   public  class M_SolutionView
    {

        public int CauseId { get; set; }
       public string CauseContent { get; set; }

        public string SuggestionContent { get; set; }

        public int ThisHappensTimes { get; set; }

        public int AllHappenSTimes { get; set; }

        public int ThisHappensTimesMax { get; set; }

        public int AllHappenSTimesMax { get; set; }
        public string RelatedContent { get; set; }

        public int ThisEventTimes { get; set; }

        public int AllEventTimes { get; set; }

        public int ThisEventTimesMax { get; set; }

        public int AllEventTimesMax { get; set; }

    }
}
