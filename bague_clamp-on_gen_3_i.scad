/*
File: bague clamp on gen 3.scad (avant clip blocage NG)

Description: clip qui permet de bloquer la bague de guidage, cette Nouvelle génération est faite avec une partie flexible sous tension

Auteur : Nicolas burger

*/

include <..\inkscape\clamp_on_gen3_h2.scad>

// variables

hauteur_frein=20; // la lanière fait par défaut 13mm de large (logement coté bague prévu par défaut a 13.3mm)+2mm de part et d'autre pour arriver a module de 17mm; Avec 20mm, la laniere fait 16mm de large.
h_laniere=hauteur_frein-4;
echelle=30.6/35.4;
$fn=60;


// Levier auquel on fait le trou pour le passage de l'écrou hexagonal
module levier_gen3_(h)
difference()
{
    levier_gen3(h);
    hull()
    {
        translate([2.05,22.34,h/2])rotate([90,0,0])cylinder(d=6.8,h=20,center=true, $fn=6);
        translate([2.25,22.34,h/2])rotate([90,0,0])cylinder(d=6.1,h=20,center=true);
        translate([2.05,22.34,h/2])rotate([90,0,-90])translate([0,0,10])cylinder(d=6.8,h=20,center=true, $fn=6);
    }
    translate([2,22,h/2])rotate([90,0,-40])cylinder(d=6.8,h=20,center=true, $fn=6);
}
// centre de l'axe du levier (1.59,20.91,0)changé en (2.60, 20.90,0) puis(1.64, 22.34,0)

// On prépare la forme qui va donner les arrondis au levier
module masque_minkowsky_levier_gen3(h)
{
    minkowski() 
    {
        hull()
        {
           translate([0,-1,1])intersection()
            {
                levier_gen3(h-2);
                translate([-5,0,0])cube([10,30,h]);
            }
           translate([9,17,h/2])rotate([90,0,0])cylinder(r=8,6);
           
        }
        sphere(0.9);
    }
}

// ON mixe la forme avec les arrondis et le levier lui meme pour avoir la forme définitive sans aspérité contendante
module levier_gen3_lisse(h)
intersection()
{
    levier_gen3_(h);
    masque_minkowsky_levier_gen3(h);
}

module cerclage_gen3_(h)
difference()
{
    union()
    {
        //cerclage_gen3(h);
        translate([0,0,h/2-h/2])cerclage_gen3_dent(h);
        difference()
        {
            translate([-0.35,-3.75,0])rotate([0,0,-25])translate([2.6+0.35,22.8+3.75,h/2])rotate([90,0,-75])translate([0,0,6.2])scale([1,1.25,1])cylinder(d=12,h=4,center=true); 
            translate([15.9,18.5,-1])cylinder(r=8,h=h+2);
        }  // pour hexagone
        translate([1.2,24.2,h/2])rotate([90,0,-68])translate([0,0,13])scale([1,1.35,1])cylinder(d=11,h=3.5); // pour vis
    }
    translate([-0.35,-3.75,0])rotate([0,0,-25])translate([2.6+0.35,22.8+3.75,h/2])rotate([90,0,-75])cylinder(d=6.95,h=20,center=true, $fn=6); // trou hexagone
    translate([1.2,24.2,h/2])rotate([90,0,-68])translate([0,0,20])cylinder(d=3.9,h=40,center=true); // trou de centrage
    translate([1.2,24.2,h/2])rotate([90,0,-68])translate([0,0,16.5])cylinder(d=9.5,h=20);// trou tete de vis
    
}

module cerclage_gen3_tronq(h)
difference()
{
    union()
    {
        //cerclage_gen3(h);
        translate([0,0,h/2-h/2])cerclage_gen3_dent_tronq(h);
        difference()
        {
            translate([-0.35,-3.75,0])rotate([0,0,-25])translate([2.6+0.35,22.8+3.75,h/2])rotate([90,0,-75])translate([0,0,6.2])scale([1,1.25,1])cylinder(d=12,h=4,center=true); 
            translate([15.9,18.5,-1])cylinder(r=8,h=h+2);
        }  // pour hexagone
        translate([1.2,24.2,h/2])rotate([90,0,-68])translate([0,0,13])scale([1,1.35,1])cylinder(d=11,h=3.5); // pour vis
    }
    translate([-0.35,-3.75,0])rotate([0,0,-25])translate([2.6+0.35,22.8+3.75,h/2])rotate([90,0,-75])cylinder(d=6.95,h=20,center=true, $fn=6); // trou hexagone
    translate([1.2,24.2,h/2])rotate([90,0,-68])translate([0,0,20])cylinder(d=3.9,h=40,center=true); // trou de centrage
    translate([1.2,24.2,h/2])rotate([90,0,-68])translate([0,0,16.5])cylinder(d=9.5,h=20);// trou tete de vis
    translate([0,0,-1])cube([50,50, 2], center = true); // on rabote les oreilles  qui dépassent des 2 extrémités
    translate([0,0,h_laniere+1])cube([50,50, 2], center = true); // on rabote les oreilles  qui dépassent des 2 extrémités
    
}

module cerclage_gen3_tronq_echelle(h,ech)
{
    difference()
    {
        union()
        {
            scale([ech,ech,1])translate([0.44,3.88,0])cerclage_gen3_dent_tronq(h);
            difference()
            {
                translate([0,0,h/2])rotate([0,0,81])translate([25*ech,0,0])rotate([90,0,0])scale([1,1.25,1])translate([0,0,4*ech])cylinder(d=12*sqrt(ech),h=4*ech,center=true); 
                translate([0,0,h/2])rotate([0,0,81])translate([24.8*ech,-12.6*ech,-h/2-1])cylinder(r=8*ech,h=h+2);
                //translate([0,0,h/2])rotate([0,0,81])cube([38.5*ech,4*ech,13],center=true);
            }  // pour hexagone
            translate([0,0,h/2])rotate([0,0,112.9])translate([25.5*ech,0,0])rotate([90,0,0])scale([1,1.35,1])translate([0,0,-4.1*ech])cylinder(d=11*sqrt(ech),h=3.5*ech); // pour vis
        }
        translate([0,0,h/2])rotate([0,0,81])translate([25*ech,0,0])rotate([90,0,0])translate([0,0,4*ech])cylinder(d=6.95,h=20,center=true, $fn=6); // trou hexagone
        translate([0,0,h/2])rotate([0,0,112.9])translate([25.5*ech,0,0])rotate([90,0,0])translate([0,0,-4.1*ech])cylinder(d=3.9,h=20,center=true); // trou de centrage tige de vis
        translate([0,0,h/2])rotate([0,0,112.9])translate([25.5*ech,0,0])rotate([90,0,0])translate([0,0,(-4.1-5)*ech])cylinder(d=9.5,h=5);// trou tete de vis
        translate([0,3,-1])cube([50,50, 2], center = true); // on rabote les oreilles  qui dépassent des 2 extrémités
        translate([0,3,h_laniere+1])cube([50,50, 2], center = true); // on rabote les oreilles  qui dépassent des 2 extrémités
        
    } 
    
 }


module levier_gen3_echelle(h,ech)
difference()
{
    scale([ech,ech,1])levier_gen3(h);
    hull()
    {
        translate([2.05*ech,22.34*ech,h/2])rotate([90,0,0])cylinder(d=6.8,h=20,center=true, $fn=6);
        translate([2.25*ech,22.34*ech,h/2])rotate([90,0,0])cylinder(d=6.1,h=20,center=true);
        translate([2.05*ech,22.34*ech,h/2])rotate([90,0,-90])translate([0,0,10])cylinder(d=6.8,h=20,center=true, $fn=6);
    }
    translate([2*ech,22*ech,h/2])rotate([90,0,-40])cylinder(d=6.8,h=20,center=true, $fn=6);
}


//cerclage_gen3_dent_tronq(h_laniere);

// centre du cerclage (-1.06,-4.11,0)changé en (-1,-4.96,0)
//masque_minkowsky_levier_gen3(13);
translate([16,2,0])levier_gen3_echelle(h_laniere,echelle);
cerclage_gen3_tronq_echelle(h_laniere,echelle);

//translate([16,2,15])levier_gen3_lisse(h_laniere);
//translate([0,0,15])cerclage_gen3_tronq(h_laniere);
