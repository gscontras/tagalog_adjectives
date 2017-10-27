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

	while (stims.length < 26) {
		noun = _.sample(nouns);
		pred1 = _.sample(adjectives);
		pred2 = _.sample(adjectives);
		if (pred1.Class!=pred2.Class) {
			stims.push(
				{
					"Predicate1":pred1.Predicate,
					"Class1":pred1.Class,	
					"Linker1": pred1.Linker,
					"Predicate2":pred2.Predicate,
					"Class2":pred2.Class,			
					"Linker2": pred2.Linker,
					"Noun":noun.Noun,
					"NounClass":noun.NounClass
				}			
			);
		}
	}
		
	return stims;
	
}