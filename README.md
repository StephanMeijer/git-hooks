# StephanMeijer/git-hooks

## Installation

```
git clone https://github.com/StephanMeijer/git-hooks.git ~/.gitconfigdir
```

And put in your `.bashrc` (optional):

```
alias hookup="rm -rf .git/hooks && ln -s ~/.gitconfigdir/hooks .git/hooks && echo \"Hooked up!\""
```

And then run within a Git repository:

```
hookup
```

Or run:

```
rm -rf .git/hooks && ln -s ~/.gitconfigdir/hooks .git/hooks && echo \"Hooked up!\"
```

Customization of this is of course possible.

## License

See [LICENSE.md](LICENSE.md)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.