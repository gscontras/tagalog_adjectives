// 40 most frequent noun-predicate combinations in the BNC

//[
//		{"Sentence": "box red", "Predicate": "red", "Noun": "box"},
//		{"Sentence": "box big", "Predicate": "big", "Noun": "box"}
//		]

var adjectives = _.shuffle([
		{"Predicate":	"luma"	, "Class":	"age"	, "Linker":	"ng"	},
{"Predicate":	"bago"	, "Class":	"age"	, "Linker":	"ng"	},
{"Predicate":	"bulok"	, "Class":	"age"	, "Linker":	" na"	},
{"Predicate":	"sariwa"	, "Class":	"age"	, "Linker":	"ng"	},
{"Predicate":	"pula"	, "Class":	"color"	, "Linker":	"ng"	},
{"Predicate":	"dilaw"	, "Class":	"color"	, "Linker":	" na"	},
{"Predicate":	"berde"	, "Class":	"color"	, "Linker":	"ng"	},
{"Predicate":	"asul"	, "Class":	"color"	, "Linker":	" na"	},
{"Predicate":	"itim"	, "Class":	"color"	, "Linker":	" na"	},
{"Predicate":	"puti"	, "Class":	"color"	, "Linker":	"ng"	},
{"Predicate":	"kahoy"	, "Class":	"material"	, "Linker":	" na"	},
{"Predicate":	"aluminyo"	, "Class":	"material"	, "Linker":	"ng"	},
{"Predicate":	"bakal"	, "Class":	"material"	, "Linker":	" na"	},
{"Predicate":	"maganda"	, "Class":	"quality"	, "Linker":	"ng"	},
{"Predicate":	"sira"	, "Class":	"quality"	, "Linker":	"ng"	},
{"Predicate":	"bilog"	, "Class":	"shape"	, "Linker":	" na"	},
{"Predicate":	"cuadrado"	, "Class":	"shape"	, "Linker":	"ng"	},
{"Predicate":	"malaki"	, "Class":	"size"	, "Linker":	"ng"	},
{"Predicate":	"maliit"	, "Class":	"size"	, "Linker":	" na"	},
{"Predicate":	"tatsulok"	, "Class":	"shape"	, "Linker":	" na"	},
{"Predicate":	"parihaba"	, "Class":	"shape"	, "Linker":	"ng"	},
{"Predicate":	"maikli"	, "Class":	"size"	, "Linker":	"ng"	},
{"Predicate":	"mahaba"	, "Class":	"size"	, "Linker":	"ng"	},
{"Predicate":	"makinis"	, "Class":	"texture"	, "Linker":	" na"	},
{"Predicate":	"matigas"	, "Class":	"texture"	, "Linker":	" na"	},
{"Predicate":	"malambot"	, "Class":	"texture"	, "Linker":	" na"	}
]);

var nouns = [
		{"Noun":	"mansanas"	, "NounClass":	"food"	},
{"Noun":	"saging"	, "NounClass":	"food"	},
{"Noun":	"karot"	, "NounClass":	"food"	},
{"Noun":	"keso"	, "NounClass":	"food"	},
{"Noun":	"kamatis"	, "NounClass":	"food"	},
{"Noun":	"silya"	, "NounClass":	"furniture"	},
{"Noun":	"sopa"	, "NounClass":	"furniture"	},
{"Noun":	"lampara"	, "NounClass":	"furniture"	},
{"Noun":	"television"	, "NounClass":	"furniture"	},
{"Noun":	"mesa"	, "NounClass":	"furniture"	}							
];

var stimuli =  makeStims();

function makeStims() {
	stims = [];

	for (var i=0; i<adjectives.length; i++) {
		noun = _.sample(nouns);
		stims.push(
			{
				"Predicate":adjectives[i].Predicate,
				"Class":adjectives[i].Class,				
				"Noun":noun.Noun,
				"NounClass":noun.NounClass
			}
			);
		}
		
	return stims;
	
}