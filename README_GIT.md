# Factorio: Wood Gasification
<img align="right" width="100" height="100" src="thumbnail.png">

Wood Gasification 4.3 turns excess wood into useful petrochemical products
through a dedicated three-stage research branch. It supports Factorio 2.0,
Space Age and optional Angel's Refining/Petrochemical Processing integration.

## Research tree

| Stage | Prerequisite | Cost | Main unlocks |
| --- | --- | ---: | --- |
| Wood pyrolysis | Oil processing | 50 automation + logistic science | Wood pyrolysis, solid fuel from wood tar, steam cracking |
| Advanced wood pyrolysis | Wood pyrolysis | 100 automation + logistic + chemical science | Hydrothermal wood pyrolysis, steam gasification |
| Synthesis gas processing | Advanced wood pyrolysis | 150 automation + logistic + chemical science | Wood carbonization, synthesis gas production and wood-tar liquefaction |

If another mod supplies synthesis gas and a technology that unlocks its
production, the synthesis recipes are attached to that technology instead. If
no suitable fluid or unlock technology exists, this mod provides its own
`wood-syngas` fluid and Synthesis gas processing technology.

### Legacy processing mode

The **Use legacy wood processing** startup setting restores the original
research progression and recipes for players who prefer the earlier production
chain. It changes the first two research costs back to 100 and 150 science packs,
shows the separate 400-pack wood-tar upgrading technology and hides the modern
pyrolysis and synthesis-gas recipes. Solid fuel from wood tar and the greenhouse
remain available in both modes.

| Legacy recipe | Ingredients | Products | Time |
| --- | --- | --- | ---: |
| Wood gasification | 10 wood | 20 petroleum gas + 8 wood tar | 5 s |
| Solid fuel from wood tar | 32 wood tar | 1 solid fuel | 5 s |
| Wood-tar upgrading | 32 wood tar + 200 water | 40 crude oil | 5 s |
| Advanced wood gasification | 20 wood + 200 water | 15 heavy oil + 15 light oil + 30 petroleum gas | 10 s |

Changing this option does not remove either set of recipe prototypes. Recipes
belonging to the inactive mode are only hidden, allowing machines in existing
saves to retain their configured recipes.

## Production chain

All visible recipes below have a base crafting time of five seconds. Their
per-cycle quantities can therefore be compared directly at crafting speed 1;
the required machine counts follow from the listed input and output ratios.

### Early processing

| Recipe | Ingredients | Products | Base machine |
| --- | --- | --- | --- |
| Wood pyrolysis | 10 wood | 10 petroleum gas + 8 wood tar + 5 wood charcoal | Chemical plant |
| Solid fuel from wood tar | 32 wood tar | 1 solid fuel | Chemical plant |
| Steam cracking of wood tar | 24 wood tar + 40 steam | 10 heavy oil + 20 petroleum gas | Chemical plant |

### Advanced processing

| Recipe | Ingredients | Products | Base machine |
| --- | --- | --- | --- |
| Hydrothermal wood pyrolysis | 20 wood + 200 water | 30 heavy oil + 30 petroleum gas | Chemical plant |
| Steam gasification of wood tar | 24 wood tar + 60 steam | 30 petroleum gas | Oil refinery |

### Synthesis gas processing

| Recipe | Ingredients | Products | Base machine |
| --- | --- | --- | --- |
| Wood carbonization | 10 wood | 6 wood charcoal | Furnace |
| Steam reforming of wood tar | 12 wood tar + 20 steam | 15 synthesis gas | Chemical plant |
| Steam gasification of wood charcoal | 10 wood charcoal + 40 steam | 30 synthesis gas, optionally 10 carbon monoxide | Chemical plant |
| Steam reforming of solid fuel | 8 solid fuel + 20 steam | 12 wood tar + 15 synthesis gas | Chemical plant |
| Synthesis-gas liquefaction of wood tar | 24 wood tar + 30 synthesis gas | 50 crude oil, optionally 10 carbon dioxide | Chemical plant |

If a compatible carbon item exists, the mod also creates `charcoal to carbon`
as an assembling-machine recipe. It is unlocked with the technology
that normally unlocks that carbon, or with Advanced wood pyrolysis when no such
technology can be identified.

## Byproducts and gases

Compatible synthesis gas, carbon, carbon monoxide and carbon dioxide
prototypes are detected by common aliases. Matching normalizes spaces,
underscores and hyphens and accepts mod-specific prefixes and suffixes while
excluding known false matches such as carbon fiber or wood charcoal.

Carbon monoxide is added to charcoal gasification whenever a compatible fluid
exists. Carbon dioxide is likewise added to wood-tar liquefaction. With Angel's
Petrochemical Processing, the flare-stack recipe is unlocked alongside either
recipe so the byproducts can be disposed of.

## Machine integration

Vanilla crafting times and machine assignments remain unchanged. With Angel's
Petrochemical Processing installed, recipes are assigned as follows:

| Recipe | Angel machine family |
| --- | --- |
| Steam reforming of wood tar | Steam cracker |
| Steam gasification of wood charcoal | Small gas refinery |
| Steam reforming of solid fuel | Oil/gas separator |
| Synthesis-gas liquefaction of wood tar | Advanced gas refinery |

When at least one visible machine in the matching Angel family exists, that
recipe is removed from chemical plants. Otherwise chemical plants remain the
fallback. Liquefaction uses the advanced gas refinery because the small gas
refinery has only one fluid input.

Angel recipe times are normalized so that one cycle takes five seconds in the
highest visible tier of the assigned machine family. The regular wood recipes
are normalized against the highest visible Angel chemical plant or oil refinery
in the same way. Lower tiers consequently need more machines to provide the
same throughput.

## Save compatibility

The original `wood-gasification`, `advanced-wood-gasification` and
`crude-oil-from-tar` recipe prototype IDs, ingredients, products and crafting
times are retained. They are hidden in modern mode and shown in legacy mode.
Likewise, modern recipes are hidden rather than removed when legacy mode is
active. Existing machines can therefore retain their configured recipes and no
migration-based renaming is required.

## Greenhouse and Space Age

The greenhouse remains independently optional through the **Enable
greenhouse** startup setting.

Without Space Age, its wood recipe consumes 20 wood and 200 water and returns
40 wood: a net gain of 20 wood per cycle. With Space Age, the tree-seed recipe
consumes 5 tree seeds and 200 water and returns 20 wood plus 6 tree seeds: the
same net gain of 20 wood, plus one seed. The configured wood output rate controls
the cycle time of either variant.

Space Age also adds greenhouse recipes for Yumako and Jellynut and can add tree
seeds to eligible trees and plants. By default, the greenhouse and tree-seed
recipe are unlocked with Wood pyrolysis. The **Require Gleba for Greenhouse
Tech** setting instead attaches them to Agriculture and Tree seeding. Yumako and
Jellynut cultivation remain tied to their corresponding technologies.

## Languages

English, Dutch, German, Russian, French, Polish, Spanish, Italian and Portuguese
locale files are included.

## Credits

The mod continues the discontinued Wood Gas mod with the original author's
permission. Artwork contributed by snouz remains included alongside newer
wood-processing artwork.
