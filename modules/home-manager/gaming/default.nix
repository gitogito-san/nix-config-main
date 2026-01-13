{ pkgs, ... }:
{
  home.packages = [
    pkgs.prismlauncher # Recursive instance-based Minecraft management.
    pkgs.dwarf-fortress-full
    pkgs.cataclysm-dda # Hardcore post-apocalyptic survival sandbox.
    pkgs.openttd # Large-scale transport network optimization.
    pkgs.simutrans # Detailed economic logistics simulation.
    pkgs.freeciv # Open-source global empire strategy.
    pkgs.freeorion # Galactic-scale 4X space colonization.
    pkgs.unciv # Minimalist, logic-accurate 4X strategy.
    pkgs.mindustry # Supply-chain driven tower defense.
    # pkgs.colobot # Scriptable 3D planetary exploration. # Broken: 2026-01 Compile Error
    pkgs.endless-sky # 2D sandbox space trade and combat.
    pkgs.pioneer # Realistic Newtonian orbital mechanics.
    pkgs.crawl # Pure tactical-focused roguelike (DCSS).
    pkgs.nethack # Arcane, high-interaction classic roguelike.
    pkgs.shattered-pixel-dungeon # Streamlined and balanced dungeon crawler.
    pkgs.frotz # Universal Z-machine TUI runtime.
    pkgs.gargoyle # High-fidelity, aesthetic IF renderer.
    pkgs.osu-lazer # Extensible, low-latency rhythm platform.
  ];

}
