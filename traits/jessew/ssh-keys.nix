{ config, pkgs, ... }: {
  users.users.jessew.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDI0cOx9lYBTZOhvM6FqEv7Tg94qZEFxJqr39pddjRyrcw/c1cR7gWlCb+6oVyyCtN17v2eU+CcdPoyUN/QemKg8tGti0EFuz951ZrLdR28paOuSeJ+PkO6Me3WU3QnUZT8dHcWuGAGRHz2WGObiwTGCidrlpYVoSXody16xxo98poME49W/ZytNPXvrurmmR6GjE4OiEafjdtIqvtJuGTR0bgOEGXaWxlnzdwXI3ZWnldJEN4h91SFtp8vxxetcjo/wDQqVeBSefBuj08UR1/ILSf9htJnhBXgpp/7kcBibQHnXUQGwDDcj1LB7lYy/7caO9499a7g9ETfjcYW3QyPnNLH0HE5RhAkvU5Wvyq8M//0w1i/+VXFvws+IHvt06xLkvHC/POLNMjB//XASKnD/s+KCqn4ZiTfJOGx46CeUJlmAX1RBkrUEguR5QlFYkT5E25xkHY0JFPfPOCRFezhDHpQmpELLF7dowxHRVNgUfk3e/Mr73koyjuUsboEeOk= u0_a185@localhost"
    # Hacktop, new ed25519 key
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIER7bHO4s2gqO9fmF2UVdKkzeCCVZ7uV6CQf0AmToC5f jessew@hacktop"
  ];
}
