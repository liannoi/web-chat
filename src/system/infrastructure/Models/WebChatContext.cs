using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace WebChat.Infrastructure.Models
{
    public partial class WebChatContext : DbContext
    {
        public WebChatContext()
        {
        }

        public WebChatContext(DbContextOptions<WebChatContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Contacts> Contacts { get; set; }
        public virtual DbSet<ConversationMessages> ConversationMessages { get; set; }
        public virtual DbSet<Conversations> Conversations { get; set; }
        public virtual DbSet<GroupAdministrators> GroupAdministrators { get; set; }
        public virtual DbSet<GroupBlacklists> GroupBlacklists { get; set; }
        public virtual DbSet<GroupMessages> GroupMessages { get; set; }
        public virtual DbSet<Groups> Groups { get; set; }
        public virtual DbSet<UserBlacklists> UserBlacklists { get; set; }
        public virtual DbSet<UserGroups> UserGroups { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseSqlServer("Server=127.0.0.1,1433;Database=WebChat;User Id=SA;Password=a91c724ac0fb29e1b71902aed66da095603799de6e46d151b9c908c41ac6526e");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Contacts>(entity =>
            {
                entity.HasKey(e => e.ContactId);

                entity.Property(e => e.Email)
                    .IsRequired()
                    .HasMaxLength(128);

                entity.Property(e => e.FirstName)
                    .IsRequired()
                    .HasMaxLength(64);

                entity.Property(e => e.LastName).HasMaxLength(64);

                entity.Property(e => e.Photo).HasMaxLength(256);
            });

            modelBuilder.Entity<ConversationMessages>(entity =>
            {
                entity.HasKey(e => e.ConversationMessageId);

                entity.Property(e => e.Message)
                    .IsRequired()
                    .HasMaxLength(1024);

                entity.HasOne(d => d.Conversation)
                    .WithMany(p => p.ConversationMessages)
                    .HasForeignKey(d => d.ConversationId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_ConversationMessages_ConversationId");
            });

            modelBuilder.Entity<Conversations>(entity =>
            {
                entity.HasKey(e => e.ConversationId);
            });

            modelBuilder.Entity<GroupAdministrators>(entity =>
            {
                entity.HasKey(e => new { e.GroupId, e.AdministratorUserId });

                entity.HasOne(d => d.Group)
                    .WithMany(p => p.GroupAdministrators)
                    .HasForeignKey(d => d.GroupId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_GroupAdministrators_GroupId");
            });

            modelBuilder.Entity<GroupBlacklists>(entity =>
            {
                entity.HasKey(e => new { e.GroupId, e.BlockedUserId });

                entity.HasOne(d => d.Group)
                    .WithMany(p => p.GroupBlacklists)
                    .HasForeignKey(d => d.GroupId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_GroupBlacklists_GroupId");
            });

            modelBuilder.Entity<GroupMessages>(entity =>
            {
                entity.HasKey(e => e.GroupMessageId);

                entity.Property(e => e.Message)
                    .IsRequired()
                    .HasMaxLength(1024);

                entity.HasOne(d => d.Group)
                    .WithMany(p => p.GroupMessages)
                    .HasForeignKey(d => d.GroupId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_GroupMessages_GroupId");
            });

            modelBuilder.Entity<Groups>(entity =>
            {
                entity.HasKey(e => e.GroupId);

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(64);
            });

            modelBuilder.Entity<UserBlacklists>(entity =>
            {
                entity.HasKey(e => new { e.OwnerUserId, e.BlockedUserId });
            });

            modelBuilder.Entity<UserGroups>(entity =>
            {
                entity.HasKey(e => new { e.GroupId, e.UserId });

                entity.HasOne(d => d.Group)
                    .WithMany(p => p.UserGroups)
                    .HasForeignKey(d => d.GroupId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("PK_UserGroups_GroupId");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
