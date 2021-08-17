String feedbackBuilder(List<String> choices) {
  String feedback = "";
  if (choices[1] == "true")
    feedback +=
        "Elfogadhatóként jelölted meg a lámákkal való tárgyduplikálást, ami - általános, bármilyen tárgyra működő duplikálás lévén - nem megengedett.\n";
  if (!(choices[0] == "true") ||
      !(choices[2] == "true") ||
      !(choices[3] == "true") ||
      !(choices[4] == "true") ||
      !(choices[5] == "true")) {
    feedback += ("Nem jelölted meg elfogadhatóként:\n" +
        (!(choices[0] == "true")
            ? " - Kimenni a nether felé az alapkövön túlra\n"
            : "") +
        (!(choices[2] == "true")
            ? " - Strongholdban zuhanó blockokat duplikálni\n"
            : "") +
        (!(choices[3] == "true") ? " - 0-tick farmot készíteni\n" : "") +
        (!(choices[4] == "true") ? " - AFK-zni\n" : "") +
        (!(choices[5] == "true")
            ? " - Iron Golemes vasfarmot készíteni\n"
            : "") +
        "pedig ez(ek) megengedett(ek).\nA többi választásod helytálló :)\n\n");
  }
  if (feedback.length == 0) feedback += "Minden választásod helyes volt!\n\n";

  return feedback;
}
