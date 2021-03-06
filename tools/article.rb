module Article
require 'date'
module_function

  def gen(root, base)
    date = Date.today.strftime('%Y-%m-%d')
    posts = root + '_posts'
    post = (posts + date).to_s + '-' + base + '.textile'
    if not File.exists?(post)
      File.open(post, File::CREAT|File::TRUNC|File::RDWR, 0644) do |out|
        
        out << '---
layout: post
published: true
date: ' + date + '
tags: [ photo ]
title: ' + base + '
---


{% include ' + base + '.html' +' %}

'
      end
    end
    return post
  end
    def today(root, base)
    date = Date.today.strftime('%Y-%m-%d')
    posts = root + '_posts'
    post = (posts + date).to_s + '-' + base + '.textile'
    if not File.exists?(post)
      File.open(post, File::CREAT|File::TRUNC|File::RDWR, 0644) do |out|
        
        out << '---
layout: post
published: true
date: ' + date + '
tags: [ ]
title: ' + base + '
---


'
      end
    end
    return post
  end
  
    def exists(root, base)
    date = Date.today.strftime('%Y-%m-%d')
    posts = root + '_posts'
    post = (posts + date).to_s + '-' + base + '.textile'
    if not File.exists?(post)
     return false
    end
    return true
  end

  
end
